package {
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.iterators.FilterIterator;
	import flash.display.Sprite;

	public class FilterIteratorExample extends Sprite {

		public function FilterIteratorExample() {
			var list : ArrayList = new ArrayList();
			var iterator : IIterator;

			list.array = [1, 2, 3, 4, 5, 6];
			iterator = new FilterIterator(list, evenFilter);
			while (iterator.hasNext()) {
				trace (iterator.next()); // 2, 4, 6
			}
		}

		private function evenFilter(item : *) : Boolean {
			// lets pass only even numbers
			return item % 2 == 0;
		}
	}
}
