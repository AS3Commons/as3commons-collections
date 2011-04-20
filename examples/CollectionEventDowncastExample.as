package {
	import org.as3commons.collections.fx.ArrayListFx;
	import org.as3commons.collections.fx.events.CollectionEvent;
	import org.as3commons.collections.fx.events.ListEvent;
	import flash.display.Sprite;

	public class CollectionEventDowncastExample extends Sprite {

		public function CollectionEventDowncastExample() {
			var list : ArrayListFx = new ArrayListFx();
			list.addEventListener(CollectionEvent.COLLECTION_CHANGED, changedHandler);
			list.addEventListener(CollectionEvent.COLLECTION_CHANGED, changedHandler2);
			list.add(1);
		}
		
		// possibility 1
		private function changedHandler(e : CollectionEvent) : void {
			var listEvent : ListEvent = e as ListEvent;
			trace (listEvent.index, listEvent.item); // 0 1
		}

		// possibility 2
		private function changedHandler2(e : ListEvent) : void {
			trace (e.index, e.item); // 0 1
		}
	}
}
