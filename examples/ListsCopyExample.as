package {
	import org.as3commons.collections.framework.IList;
	import org.as3commons.collections.utils.Lists;
	import org.as3commons.collections.utils.NumericComparator;
	import flash.display.Sprite;

	public class ListsCopyExample extends Sprite {
		public function ListsCopyExample() {
			// source
			var source : IList = Lists.newArrayList(1, 2, 3, 4);
			trace (source.toArray() + "\n");
			//	1, 2, 3, 4
			
			// copy all
			var list : IList = Lists.newSortedList(
				new NumericComparator(),
				5, 6, 7, 8
			);
			trace (list.toArray() + "\n");
			//	5, 6, 7, 8
			Lists.copy(source, list);
			trace (list.toArray() + "\n");
			//	1, 2, 3, 4, 5, 6, 7, 8

			// copy only even items
			list = Lists.newSortedList(
				new NumericComparator(),
				6, 8
			);
			trace (list.toArray() + "\n");
			//	6, 8
			Lists.copy(source, list, evenFilter);
			trace (list.toArray() + "\n");
			//	2, 4, 6, 8
		}
		
		private function evenFilter(item : *) : Boolean {
			return item % 2 == 0;
		}

	}
}