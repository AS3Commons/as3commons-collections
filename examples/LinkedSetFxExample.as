package {
	import org.as3commons.collections.framework.ISetIterator;
	import org.as3commons.collections.fx.LinkedSetFx;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.SetEvent;
	import org.as3commons.collections.utils.NumericComparator;
	import flash.display.Sprite;

	public class LinkedSetFxExample extends Sprite {

		public function LinkedSetFxExample() {
			var theSet : LinkedSetFx = new LinkedSetFx();
			theSet.addEventListener(CollectionEvent.COLLECTION_CHANGED, changedHandler);
			
			theSet.add(1);
			theSet.add(3);
			theSet.add(2);
			theSet.add(2); // no event (2 already contained)
			
			theSet.addFirst(4);
			theSet.addLast(5);

			theSet.addBefore(2, 6);
			theSet.addAfter(2, 7);

			theSet.replace(3, 8);
			theSet.replace(1, 9);

			theSet.removeFirst();
			theSet.removeLast();
			theSet.remove(8);
			theSet.remove(6);
			theSet.remove(10); // no event (10 not contained)

			theSet.reverse();
			theSet.sort(new NumericComparator());

			theSet.clear();

			// [1] added                         [1]
			// [3] added after 1                 [1 3]
			// [2] added after 3                 [1 3 2]
			// [4] added before 1                [4 1 3 2]
			// [5] added after 2                 [4 1 3 2 5]
			// [6] added after 3 before 2        [4 1 3 6 2 5]
			// [7] added after 2 before 5        [4 1 3 6 2 7 5]
			// [8] replaced after 1 before 6     [4 1 8 6 2 7 5]
			// [9] replaced after 4 before 8     [4 9 8 6 2 7 5]
			// [4] removed before 9              [9 8 6 2 7 5]
			// [5] removed after 7               [9 8 6 2 7]
			// [8] removed after 9 before 6      [9 6 2 7]
			// [6] removed after 9 before 2      [9 2 7]
			// Reset                             [7 2 9]
			// Reset                             [2 7 9]
			// Reset                             []
		}

		private function changedHandler(e : SetEvent) : void {
			var info : String = "";
			var iterator : ISetIterator;
			
			switch (e.kind) {
				case CollectionEvent.ITEM_ADDED:
					info += "[" + e.item + "] added";

					iterator = e.iterator() as ISetIterator;
					if (iterator.previousItem !== undefined) info += " after " + iterator.previousItem;
					iterator.next();
					if (iterator.nextItem !== undefined) info += " before " + iterator.nextItem;
					break;

				case CollectionEvent.ITEM_REMOVED:
					info += "[" + e.item + "] removed";

					iterator = e.iterator() as ISetIterator;
					if (iterator.previousItem !== undefined) info += " after " + iterator.previousItem;
					if (iterator.nextItem !== undefined) info += " before " + iterator.nextItem;
					break;

				case CollectionEvent.ITEM_REPLACED:
					info += "[" + e.item + "] replaced";

					iterator = e.iterator() as ISetIterator;
					if (iterator.previousItem !== undefined) info += " after " + iterator.previousItem;
					iterator.next();
					if (iterator.nextItem !== undefined) info += " before " + iterator.nextItem;
					break;

				case CollectionEvent.RESET:
					info += ("Reset");
					break;
			}
			
			for (var i : uint = info.length; i < 34; i++) info += " ";
			info += "[" + e.set.toArray().join(" ") + "]";
			trace (info);
		}
	}
}
