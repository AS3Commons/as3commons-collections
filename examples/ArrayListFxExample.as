package {
	import org.as3commons.collections.fx.ArrayListFx;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.ListEvent;
	import org.as3commons.collections.utils.NumericComparator;
	import flash.display.Sprite;

	public class ArrayListFxExample extends Sprite {

		public function ArrayListFxExample() {
			var list : ArrayListFx = new ArrayListFx();
			list.addEventListener(CollectionEvent.COLLECTION_CHANGED, changedHandler);
			
			list.add(1);
			list.addAllAt(1, [2, 2, 4, 4, 5, 5, 6, 6, 8, 8]);
			list.addFirst(10);
			list.addLast(12);

			list.replaceAt(3, 2); // no event (item at 3 is already 2)
			list.replaceAt(6, 2);
			list.replaceAt(7, 2);

			list.removeFirst();
			list.removeLast();
			list.removeAt(2);
			list.removeAt(12); // no event (index > list.size)
			list.removeAllAt(2, 2);

			list.remove(6);
			list.removeAll(2);
			list.removeAll(10); // no event (10 not contained)

			list.reverse();
			list.sort(new NumericComparator());
			list.array = [1, 2, 3, 4, 5];

			list.clear();

			// [1] added at 0                        [1]
			// [2,2,4,4,5,5,6,6,8,8] added at 1      [1 2 2 4 4 5 5 6 6 8 8]
			// [10] added at 0                       [10 1 2 2 4 4 5 5 6 6 8 8]
			// [12] added at 12                      [10 1 2 2 4 4 5 5 6 6 8 8 12]
			// [2] replaced at 6                     [10 1 2 2 4 4 2 5 6 6 8 8 12]
			// [2] replaced at 7                     [10 1 2 2 4 4 2 2 6 6 8 8 12]
			// [10] removed at 0                     [1 2 2 4 4 2 2 6 6 8 8 12]
			// [12] removed at 11                    [1 2 2 4 4 2 2 6 6 8 8]
			// [2] removed at 2                      [1 2 4 4 2 2 6 6 8 8]
			// [4,4] removed at 2                    [1 2 2 2 6 6 8 8]
			// [6] removed at 4                      [1 2 2 2 6 8 8]
			// [2] removed at 1                      [1 2 2 6 8 8]
			// [2] removed at 1                      [1 2 6 8 8]
			// [2] removed at 1                      [1 6 8 8]
			// Reset                                 [8 8 6 1]
			// Reset                                 [1 6 8 8]
			// Reset                                 [1 2 3 4 5]
			// Reset                                 []
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
			
			for (var i : uint = info.length; i < 38; i++) info += " ";
			info += "[" + e.list.toArray().join(" ") + "]";
			trace (info);
		}
	}
}
