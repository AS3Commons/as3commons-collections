package {
	import org.as3commons.collections.framework.ISet;
	import org.as3commons.collections.utils.Sets;
	import org.as3commons.collections.utils.NumericComparator;
	import flash.display.Sprite;

	public class SetsCopyExample extends Sprite {
		public function SetsCopyExample() {
			// source
			var source : ISet = Sets.newLinkedSet(1, 2, 3, 4);
			trace (source.toArray() + "\n");
			//	1, 2, 3, 4
			
			// copy all
			var theSet : ISet = Sets.newSortedSet(
				new NumericComparator(),
				5, 6, 7, 8
			);
			trace (theSet.toArray() + "\n");
			//	5, 6, 7, 8
			Sets.copy(source, theSet);
			trace (theSet.toArray() + "\n");
			//	1, 2, 3, 4, 5, 6, 7, 8

			// copy only even items
			theSet = Sets.newSortedSet(
				new NumericComparator(),
				6, 8
			);
			trace (theSet.toArray() + "\n");
			//	6, 8
			Sets.copy(source, theSet, evenFilter);
			trace (theSet.toArray() + "\n");
			//	2, 4, 6, 8
		}
		
		private function evenFilter(item : *) : Boolean {
			return item % 2 == 0;
		}

	}
}