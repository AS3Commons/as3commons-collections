package {
	import org.as3commons.collections.utils.NumericComparator;
	import flash.utils.getQualifiedClassName;
	import org.as3commons.collections.framework.IList;
	import org.as3commons.collections.utils.Lists;
	import flash.display.Sprite;

	public class ListsCloneExample extends Sprite {

		public function ListsCloneExample() {
			// clone array list
			var list : IList = Lists.newArrayList(2, 4, 1, 3);
			var clone : IList = Lists.clone(list);
			trace (list.toArray().join("\n"));
			trace (getQualifiedClassName(clone));
			//	2
			//	4
			//	1
			//	3
			//	org.as3commons.collections::ArrayList

			// clone sorted list
			list = Lists.newSortedList(
				new NumericComparator(),
				2, 4, 1, 3
			);
			clone = Lists.clone(list);
			trace (list.toArray().join("\n"));
			trace (getQualifiedClassName(clone));
			//	1
			//	2
			//	3
			//	4
			//	org.as3commons.collections::SortedList
		}
		
	}
}