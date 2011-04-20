package {
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.fx.LinkedMapFx;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.MapEvent;
	import org.as3commons.collections.utils.NumericComparator;
	import flash.display.Sprite;

	public class LinkedMapFxExample extends Sprite {

		public function LinkedMapFxExample() {
			var map : LinkedMapFx = new LinkedMapFx();
			map.addEventListener(CollectionEvent.COLLECTION_CHANGED, changedHandler);
			
			map.add("fourA", 4);
			map.add("one", 1);
			map.add("threeA", 3);
			map.add("two", 2);
			map.add("two", 2); // no event (two already contained)
			
			map.addFirst("threeD", 3);
			map.addLast("fourB", 4);

			map.addBefore("two", "threeB", 3);
			map.addAfter("two", "threeC", 3);

			map.replaceFor("two", 22);
			map.replaceFor("one", 11);
			map.replaceFor("one", 11); // no event (11 == 11)

			map.removeFirst();
			map.removeLast();
			map.remove(6); // no event (6 not contained)
			map.removeAll(3);

			map.reverse();
			map.sort(new NumericComparator());

			map.clear();

			// [4] added                         [4]
			// [1] added after 4                 [4 1]
			// [3] added after 1                 [4 1 3]
			// [2] added after 3                 [4 1 3 2]
			// [3] added before 4                [3 4 1 3 2]
			// [4] added after 2                 [3 4 1 3 2 4]
			// [3] added after 3 before 2        [3 4 1 3 3 2 4]
			// [3] added after 2 before 4        [3 4 1 3 3 2 3 4]
			// [22] replaced after 3 before 3    [3 4 1 3 3 22 3 4]
			// [11] replaced after 4 before 3    [3 4 11 3 3 22 3 4]
			// [3] removed before 4              [4 11 3 3 22 3 4]
			// [4] removed after 3               [4 11 3 3 22 3]
			// [3] removed after 11 before 3     [4 11 3 22 3]
			// [3] removed after 11 before 22    [4 11 22 3]
			// [3] removed after 22              [4 11 22]
			// Reset                             [22 11 4]
			// Reset                             [4 11 22]
			// Reset                             []
		}

		private function changedHandler(e : MapEvent) : void {
			var info : String = "";
			var iterator : IMapIterator;
			
			switch (e.kind) {
				case CollectionEvent.ITEM_ADDED:
					info += "[" + e.item + "] added";

					iterator = e.iterator() as IMapIterator;
					if (iterator.previousKey !== undefined) info += " after " + e.map.itemFor(iterator.previousKey);
					iterator.next();
					if (iterator.nextKey !== undefined) info += " before " + e.map.itemFor(iterator.nextKey);
					break;

				case CollectionEvent.ITEM_REMOVED:
					info += "[" + e.item + "] removed";

					iterator = e.iterator() as IMapIterator;
					if (iterator.previousKey !== undefined) info += " after " + e.map.itemFor(iterator.previousKey);
					if (iterator.nextKey !== undefined) info += " before " + e.map.itemFor(iterator.nextKey);
					break;

				case CollectionEvent.ITEM_REPLACED:
					info += "[" + e.item + "] replaced";

					iterator = e.iterator() as IMapIterator;
					if (iterator.previousKey !== undefined) info += " after " + e.map.itemFor(iterator.previousKey);
					iterator.next();
					if (iterator.nextKey !== undefined) info += " before " + e.map.itemFor(iterator.nextKey);
					break;

				case CollectionEvent.RESET:
					info += ("Reset");
					break;
			}
			
			for (var i : uint = info.length; i < 34; i++) info += " ";
			info += "[" + e.map.toArray().join(" ") + "]";
			trace (info);
		}
	}
}
