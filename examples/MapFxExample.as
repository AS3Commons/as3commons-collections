package {
	import org.as3commons.collections.fx.MapFx;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.MapEvent;
	import flash.display.Sprite;

	public class MapFxExample extends Sprite {

		public function MapFxExample() {
			var map : MapFx = new MapFx();
			map.addEventListener(CollectionEvent.COLLECTION_CHANGED, changedHandler);
			
			map.add("five", 5);
			map.add("two", 2);
			map.add("threeA", "three");
			map.add("two", 2); // no event (two already contained)
			map.add("four", 4);
			map.add("threeB", "three");
			map.add("one", 1);
			map.add("threeC", "three");

			map.replaceFor("four", -4);
			map.replaceFor("one", 1); // no event (1 === 1)

			map.removeKey("one");
			map.remove(6); // no event (6 not contained)
			map.removeAll("three");

			map.clear();

			// [five=5] added                    [5]
			// [two=2] added                     [2 5]
			// [threeA=three] added              [2 5 three]
			// [four=4] added                    [2 4 5 three]
			// [threeB=three] added              [2 4 5 three three]
			// [one=1] added                     [2 4 1 5 three three]
			// [threeC=three] added              [2 three 5 three 4 1 three]
			// [four=-4] replaced                [2 three 5 three -4 1 three]
			// [one=1] removed                   [2 three 5 three -4 three]
			// [threeC=three] removed            [2 5 three -4 three]
			// [threeA=three] removed            [2 5 -4 three]
			// [threeB=three] removed            [2 5 -4]
			// Reset                             []
		}
		
		private function changedHandler(e : MapEvent) : void {
			var info : String = "";
			
			switch (e.kind) {
				case CollectionEvent.ITEM_ADDED:
					info += "[" + e.key + "=" + e.item + "] added";
					break;

				case CollectionEvent.ITEM_REMOVED:
					info += "[" + e.key + "=" + e.item + "] removed";
					break;

				case CollectionEvent.ITEM_REPLACED:
					info += "[" + e.key + "=" + e.item + "] replaced";
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
