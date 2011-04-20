package {
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.fx.SortedMapFx;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.MapEvent;
	import org.as3commons.collections.utils.NumericComparator;
	import flash.display.Sprite;

	public class SortedMapFxExample extends Sprite {

		public function SortedMapFxExample() {
			var map : SortedMapFx = new SortedMapFx(new NumericComparator());
			map.addEventListener(CollectionEvent.COLLECTION_CHANGED, changedHandler);
			
			map.add("five", 5);
			map.add("two", 2);
			map.add("threeA", 3);
			map.add("two", 2); // no event (two already contained)
			map.add("four", 4);
			map.add("threeB", 3);
			map.add("one", 1);
			map.add("threeC", 3);

			map.replaceFor("four", -4);
			map.replaceFor("one", 1); // no event (1 === 1)

			map.removeKey("one");
			map.removeFirst();
			map.removeLast();
			map.remove(6); // no event (6 not contained)
			map.removeAll(3);

			map.clear();

			// [5] added                         [5]
			// [2] added before 5                [2 5]
			// [3] added after 2 before 5        [2 3 5]
			// [4] added after 3 before 5        [2 3 4 5]
			// [3] added after 3 before 4        [2 3 3 4 5]
			// [1] added before 2                [1 2 3 3 4 5]
			// [3] added after 3 before 4        [1 2 3 3 3 4 5]
			// [4] removed after 3 before 5      [1 2 3 3 3 5]
			// [-4] added before 1               [-4 1 2 3 3 3 5]
			// [1] removed after -4 before 2     [-4 2 3 3 3 5]
			// [-4] removed before 2             [2 3 3 3 5]
			// [5] removed after 3               [2 3 3 3]
			// [3] removed after 2 before 3      [2 3 3]
			// [3] removed after 2 before 3      [2 3]
			// [3] removed after 2               [2]
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
