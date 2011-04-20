package {
	import org.as3commons.collections.LinkedList;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.ILinkedList;
	import org.as3commons.collections.framework.ILinkedListIterator;
	import flash.display.Sprite;

	public class LinkedListExample extends Sprite {

		public function LinkedListExample() {
			var list : ILinkedList = new LinkedList();
			
			// Add
			
			list.add(4);
			list.add(1);
			list.add(3);
			list.add(5);
			list.add(2);
			trace (list.toArray()); // 4,1,3,5,2
			
			list.addFirst(6);
			list.addLast(7);
			trace (list.toArray()); // 6,4,1,3,5,2,7

			// Inspection
			
			trace (list.first); // 6
			trace (list.last); // 7
			
			// Iterator

			var iterator : IIterator = list.iterator();
			trace (iterator is IIterator); // true
			trace (iterator is ICollectionIterator); // true
			trace (iterator is ILinkedListIterator); // true
			
			while (iterator.hasNext()) {
				trace (iterator.next()); // 6,4,1,3,5,2,7
			}

			// Linked list iterator

			var lli : ILinkedListIterator = list.iterator() as ILinkedListIterator;
			trace (lli.previousItem + " [" + lli.current + "] " + lli.nextItem);
			while (lli.hasNext()) {
				lli.next();
				trace (lli.previousItem + " [" + lli.current + "] " + lli.nextItem);
			}

			// undefined [undefined] 6
			// 6 [6] 4
			// 4 [4] 1
			// 1 [1] 3
			// 3 [3] 5
			// 5 [5] 2
			// 2 [2] 7
			// 7 [7] undefined

			// Remove

			list.removeFirst();
			list.removeFirst();
			list.removeLast();
			list.removeLast();
			trace (list.toArray()); // 1,3,5
		}
	}
}
