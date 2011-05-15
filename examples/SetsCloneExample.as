package {
	import org.as3commons.collections.utils.NumericComparator;
	import flash.utils.getQualifiedClassName;
	import org.as3commons.collections.framework.ISet;
	import org.as3commons.collections.utils.Sets;
	import flash.display.Sprite;

	public class SetsCloneExample extends Sprite {

		public function SetsCloneExample() {
			// clone simple set
			var theSet : ISet = Sets.newSet(2, 4, 1, 3);
			var clone : ISet = Sets.clone(theSet);
			trace (theSet.toArray().join("\n"));
			trace (getQualifiedClassName(clone));
			//	1
			//	2
			//	3
			//	4
			//	org.as3commons.collections::Set
			
			// clone linked theSet
			theSet = Sets.newLinkedSet(2, 4, 1, 3);
			clone = Sets.clone(theSet);
			trace (theSet.toArray().join("\n"));
			trace (getQualifiedClassName(clone));
			//	2
			//	4
			//	1
			//	3
			//	org.as3commons.collections::LinkedSet

			// clone sorted set
			theSet = Sets.newSortedSet(
				new NumericComparator(),
				2, 4, 1, 3
			);
			clone = Sets.clone(theSet);
			trace (theSet.toArray().join("\n"));
			trace (getQualifiedClassName(clone));
			//	1
			//	2
			//	3
			//	4
			//	org.as3commons.collections::SortedSet
		}
		
	}
}