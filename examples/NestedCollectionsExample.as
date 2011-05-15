package {
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.LinkedSet;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.utils.*;
	import flash.display.Sprite;

	public class NestedCollectionsExample extends Sprite {

		public function NestedCollectionsExample() {
			// nested array list
			var list : ArrayList = Lists.newArrayList(
				Lists.newArrayList(1, 2),
				Lists.newArrayList(
					Lists.newArrayList(3, 4),
					Lists.newArrayList(5, 6)
				),
				Lists.newArrayList(7, 8),
				Lists.newArrayList(
					Lists.newArrayList(9, 10),
					Lists.newArrayList(11, 12)
				)
			);
			trace (CollectionUtils.dumpAsString(list));
			//	[object ArrayList]
			//	.......[object ArrayList]
			//	..............1
			//	..............2
			//	.......[object ArrayList]
			//	..............[object ArrayList]
			//	.....................3
			//	.....................4
			//	..............[object ArrayList]
			//	.....................5
			//	.....................6
			//	.......[object ArrayList]
			//	..............7
			//	..............8
			//	.......[object ArrayList]
			//	..............[object ArrayList]
			//	.....................9
			//	.....................10
			//	..............[object ArrayList]
			//	.....................11
			//	.....................12			
			
			// nested mixed collection
			var c : IComparator = new NumericComparator();
			var theSet : LinkedSet = Sets.newLinkedSet(
				Maps.newLinkedMap("one", 1, "two", 2),
				Lists.newArrayList(
					Sets.newSortedSet(c, 4, 3),
					LinkedLists.newLinkedList(5, 6)
				),
				Lists.newSortedList(c, 8, 7),
				Lists.newArrayList(
					Maps.newLinkedMap("nine", 9, "ten", 10),
					Maps.newSortedMap(c, "twelve", 12, "eleven", 11)
				)
			);
			trace (CollectionUtils.dumpAsString(theSet));
			//	[object LinkedSet]
			//	.......[object LinkedMap]
			//	..............1
			//	..............2
			//	.......[object ArrayList]
			//	..............[object SortedSet]
			//	.....................3
			//	.....................4
			//	..............[object LinkedList]
			//	.....................5
			//	.....................6
			//	.......[object SortedList]
			//	..............7
			//	..............8
			//	.......[object ArrayList]
			//	..............[object LinkedMap]
			//	.....................9
			//	.....................10
			//	..............[object SortedMap]
			//	.....................11
			//	.....................12			
		}
	}
}