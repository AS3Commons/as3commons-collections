package {
	import org.as3commons.collections.fx.SetFx;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.SetEvent;
	import flash.display.Sprite;

	public class SetFxExample extends Sprite {

		public function SetFxExample() {
			var theSet : SetFx = new SetFx();
			theSet.addEventListener(CollectionEvent.COLLECTION_CHANGED, changedHandler);
			
			theSet.add(5);
			theSet.add(2);
			theSet.add(2); // no event (2 already contained)
			theSet.add("one");
			theSet.add("four");
			theSet.add(5); // no event (5 already contained)
			theSet.add(true); // no event (5 already contained)

			theSet.remove(5);
			theSet.remove(6); // no event (6 not contained)
			theSet.remove(true);

			theSet.clear();

			// [5] added                     [5]
			// [2] added                     [2 5]
			// [one] added                   [one 2 5]
			// [four] added                  [four one 2 5]
			// [true] added                  [four one 2 true 5]
			// [5] removed                   [four one 2 true]
			// [true] removed                [four one 2]
			// Reset                         []
		}
		
		private function changedHandler(e : SetEvent) : void {
			var info : String = "";
			
			switch (e.kind) {
				case CollectionEvent.ITEM_ADDED:
					info += "[" + e.item + "] added";
					break;

				case CollectionEvent.ITEM_REMOVED:
					info += "[" + e.item + "] removed";
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
