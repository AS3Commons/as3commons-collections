package {
	import org.as3commons.collections.SortedList;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IListIterator;
	import org.as3commons.collections.utils.StringComparator;
	import flash.display.Sprite;

	public class SortedListExample extends Sprite {

		public function SortedListExample() {
			var list : SortedList = new SortedList(new StringComparator());
			
			// Add

			list.add("d");
			list.add("a");
			list.add("a");
			list.add("f");
			list.add("c");
			list.add("b");
			list.add("a");
			list.add("c");
			trace (list.toArray()); // a,a,a,b,c,c,d,f

			list.array = ["d", "a", "a", "f", "c", "b", "a", "c"];
			trace (list.toArray()); // a,a,a,b,c,c,d,f

			// Inspection

			trace (list.first); // a
			trace (list.last); // f

			trace (list.hasEqual("a")); // true
			trace (list.hasEqual("e")); // false
			trace (list.equalIndices("a")); // 0,1,2

			trace (list.lesserIndex("a")); // -1
			trace (list.lesserIndex("c")); // 3
			
			trace (list.higherIndex("c")); // 6
			trace (list.higherIndex("f")); // -1
			trace (list.higherIndex("x")); // -1

			// Iterator
			
			var iterator : IIterator = list.iterator();
			trace (iterator is IIterator); // true
			trace (iterator is ICollectionIterator); // true
			trace (iterator is IListIterator); // true
			
			while (iterator.hasNext()) {
				trace (iterator.next()); // a,a,a,b,c,c,d,f
			}
		}
	}
}
