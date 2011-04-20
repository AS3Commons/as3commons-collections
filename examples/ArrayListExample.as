package {
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IListIterator;
	import org.as3commons.collections.framework.IOrderedListIterator;
	import org.as3commons.collections.utils.StringComparator;
	import flash.display.Sprite;

	public class ArrayListExample extends Sprite {

		public function ArrayListExample() {
			var list : ArrayList = new ArrayList();
			
			// Add

			list.add("a");
			list.add("b");
			list.addAllAt(1, ["c", "d"]);
			trace (list.toArray()); // a,c,d,b

			list.addFirst("e");
			list.addLast("a");
			list.addAt(3, "a");
			trace (list.toArray()); // e,a,c,a,d,b,a
			
			// Replace

			list.replaceAt(2, "a");
			list.replaceAt(3, "f");
			trace (list.toArray()); // e,a,a,f,d,b,a

			// Inspection

			trace (list.size); // 7
			trace (list.has("b")); // true
			trace (list.itemAt(3)); // f
			trace (list.firstIndexOf("a")); // 1
			trace (list.lastIndexOf("a")); // 6
			trace (list.count("a")); // 3
			
			// Reorder

			list.reverse();
			trace (list.toArray()); // a,b,d,f,a,a,e

			list.sort(new StringComparator());
			trace (list.toArray()); // a,a,a,b,d,e,f
			
			// Iterator

			var iterator : IIterator = list.iterator();
			trace (iterator is IIterator); // true
			trace (iterator is ICollectionIterator); // true
			trace (iterator is IListIterator); // true
			trace (iterator is IOrderedListIterator); // true

			while (iterator.hasNext()) {
				trace (iterator.next()); // a,a,a,b,d,e,f
			}

			// List iterator

			var listIterator : IListIterator = list.iterator() as IListIterator;
			while (listIterator.hasNext()) {
				listIterator.next();
				trace (listIterator.index + "=" + listIterator.current);
			}

			// 0=a
			// 1=a
			// 2=a
			// 3=b
			// 4=d
			// 5=e
			// 6=f

			// Remove

			list.remove("a");
			trace (list.toArray()); // a,a,b,d,e,f

			list.removeAll("a");
			trace (list.toArray()); // b,d,e,f

			list.removeAt(1);
			list.removeFirst();
			list.removeLast();
			trace (list.toArray()); // e

			list.clear();
			trace (list.toArray()); // []
		}
	}
}
