package {
	import org.as3commons.collections.framework.ISetIterator;
	import org.as3commons.collections.fx.SortedSetFx;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.SetEvent;
	import org.as3commons.collections.utils.NumericComparator;
	import flash.display.Sprite;

	public class SortedSetFxExample extends Sprite {

		public function SortedSetFxExample() {
			var theSet : SortedSetFx = new SortedSetFx(new NumericComparator());
			theSet.addEventListener(CollectionEvent.COLLECTION_CHANGED, changedHandler);
			
			theSet.add(5);
			theSet.add(2);
			theSet.add(2); // no event (2 already contained)
			theSet.add(1);
			theSet.add(4);
			theSet.add(5); // no event (5 already contained)

			theSet.removeFirst();
			theSet.removeLast();
			theSet.remove(6); // no event (6 not contained)

			theSet.clear();

			// [5] added                     [5]
			// [2] added before 5            [2 5]
			// [1] added before 2            [1 2 5]
			// [4] added after 2 before 5    [1 2 4 5]
			// [1] removed before 2          [2 4 5]
			// [5] removed after 4           [2 4]
			// Reset                         []
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

				case CollectionEvent.RESET:
					info += ("Reset");
					break;
			}
			
			for (var i : uint = info.length; i < 30; i++) info += " ";
			info += "[" + e.set.toArray().join(" ") + "]";
			trace (info);
		}
	}
}
