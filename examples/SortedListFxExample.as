package {
	import org.as3commons.collections.fx.SortedListFx;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.ListEvent;
	import org.as3commons.collections.utils.NumericComparator;
	import flash.display.Sprite;

	public class SortedListFxExample extends Sprite {

		public function SortedListFxExample() {
			var list : SortedListFx = new SortedListFx(new NumericComparator());
			list.addEventListener(CollectionEvent.COLLECTION_CHANGED, changedHandler);
			
			list.array = [4, 2, 3, 1, 2, 6, 8, 4];
			list.add(5);
			list.add(2);
			list.add(2);
			list.add(1);

			list.removeFirst();
			list.removeLast();
			list.removeAt(5);
			list.removeAt(12); // no event (index > list.size)
			list.removeAllAt(4, 2);

			list.remove(6);
			list.removeAll(2);
			list.removeAll(10); // no event (10 not contained)

			list.clear();

			// Reset                   [1 2 2 3 4 4 6 8]
			// [5] added at 6          [1 2 2 3 4 4 5 6 8]
			// [2] added at 3          [1 2 2 2 3 4 4 5 6 8]
			// [2] added at 4          [1 2 2 2 2 3 4 4 5 6 8]
			// [1] added at 1          [1 1 2 2 2 2 3 4 4 5 6 8]
			// [1] removed at 0        [1 2 2 2 2 3 4 4 5 6 8]
			// [8] removed at 10       [1 2 2 2 2 3 4 4 5 6]
			// [3] removed at 5        [1 2 2 2 2 4 4 5 6]
			// [2,4] removed at 4      [1 2 2 2 4 5 6]
			// [6] removed at 6        [1 2 2 2 4 5]
			// [2] removed at 1        [1 2 2 4 5]
			// [2] removed at 1        [1 2 4 5]
			// [2] removed at 1        [1 4 5]
			// Reset                   []
		}
		
		private function changedHandler(e : ListEvent) : void {
			var info : String = "";
			var items : *;
			
			switch (e.kind) {
				case CollectionEvent.ITEM_ADDED:
					items = e.numItems == 1 ? e.item : e.items;
					info += "[" + items + "] added at " + e.index;
					break;

				case CollectionEvent.ITEM_REMOVED:
					items = e.numItems == 1 ? e.item : e.items;
					info += "[" + items + "] removed at " + e.index;
					break;

				case CollectionEvent.ITEM_REPLACED:
					info += "[" + e.item + "] replaced at " + e.index;
					break;

				case CollectionEvent.RESET:
					info += ("Reset");
					break;
			}
			
			for (var i : uint = info.length; i < 24; i++) info += " ";
			info += "[" + e.list.toArray().join(" ") + "]";
			trace (info);
		}
	}
}
