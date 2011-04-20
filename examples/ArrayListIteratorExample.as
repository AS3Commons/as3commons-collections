package {
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.IOrderedListIterator;
	import flash.display.Sprite;

	public class ArrayListIteratorExample extends Sprite {

		public function ArrayListIteratorExample() {
			var list : ArrayList = new ArrayList();
			var iterator : IOrderedListIterator;
			var item : *;
			
			// ^ = cursor, [n] = current
			
			// Navigation
			
			list.array = [1, 2, 3];
			iterator = list.iterator() as IOrderedListIterator;
			
			                          //  ^  1  2  3
			iterator.next();          // [1] ^  2  3
			iterator.next();          //  1 [2] ^  3
			iterator.next();          //  1  2 [3] ^
			iterator.next();          //  1  2  3  ^
			iterator.previous();      //  1  2  ^ [3]
			iterator.previous();      //  1  ^ [2] 3
			iterator.previous();      //  ^ [1] 2  3
			iterator.previous();      //  ^  1  2  3

			iterator.next();          // [1] ^  2  3
			iterator.next();          //  1 [2] ^  3
			iterator.start();         //  ^  1  2  3

			iterator.next();          // [1] ^  2  3
			iterator.next();          //  1 [2] ^  3
			iterator.end();           //  1  2  3  ^
			
			// Current and index

			iterator = list.iterator() as IOrderedListIterator;
			
			with (iterator) {
				trace (index, current, previousIndex, nextIndex);
				// -1 undefined -1 0

				next();
				trace (index, current, previousIndex, nextIndex);
				// 0 1 0 1

				next();
				trace (index, current, previousIndex, nextIndex);
				// 1 2 1 2

				next();
				trace (index, current, previousIndex, nextIndex);
				// 2 3 2 -1

				next();
				trace (index, current, previousIndex, nextIndex);
				// -1 undefined 2 -1
			}
			
			// Start position
			
			iterator = list.iterator() as IOrderedListIterator;   //  ^  1  2  3
			iterator = list.iterator(1) as IOrderedListIterator;  //  1  ^  2  3
			iterator = list.iterator(2) as IOrderedListIterator;  //  1  2  ^  3
			iterator = list.iterator(10) as IOrderedListIterator; //  1  2  3  ^

			// Replace

			iterator = list.iterator() as IOrderedListIterator;

			                          //  ^  1  2  3
			iterator.next();          // [1] ^  2  3
			iterator.next();          //  1 [2] ^  3
			iterator.replace(4);      //  1 [4] ^  3
			iterator.next();          //  1  4 [3] ^
			iterator.replace(5);      //  1  4 [5] ^
			iterator.next();          //  1  4  5  ^
			iterator.replace(6);      //  1  4  5  ^

			// Remove

			list.array = [1, 2, 3];
			iterator = list.iterator() as IOrderedListIterator;
			
			                          //  ^  1  2  3
			iterator.next();          // [1] ^  2  3
			iterator.next();          //  1 [2] ^  3
			iterator.remove();        //  1  ^  3
			iterator.next();          //  1 [3] ^
			iterator.remove();        //  1  ^
			iterator.remove();        //  1  ^

			// Add

			list.array = [1, 2, 3];
			iterator = list.iterator() as IOrderedListIterator;
			
			                          //  ^  1  2  3
			iterator.addAfter(4);     //  ^  4  1  2  3
			iterator.addBefore(5);    //  5  ^  4  1  2  3

			iterator.next();          //  5 [4] ^  1  2  3
			iterator.next();          //  5  4 [1] ^  2  3
			iterator.addBefore(6);    //  5  4  1  6  ^  2  3
			iterator.addAfter(7);     //  5  4  1  6  ^  7  2  3

			iterator.next();          //  5  4  1  6 [7] ^  2  3
			iterator.next();          //  5  4  1  6  7 [2] ^  3
			iterator.next();          //  5  4  1  6  7  2 [3] ^
			iterator.addBefore(8);    //  5  4  1  6  7  2  3  8  ^
			iterator.addAfter(9);     //  5  4  1  6  7  2  3  8  ^  9
			
			// Add during iteration

			list.array = [1, 2, 3];
			iterator = list.iterator() as IOrderedListIterator;
			while (iterator.hasNext()) {
				item = iterator.next();
				trace (item); // 1,2,5,3,7

				if (item == 1) iterator.addBefore(4);   //  1  4  ^  2  3
				if (item == 2) iterator.addAfter(5);    //  1  4  2  ^  5  3
				if (item == 5) iterator.addBefore(6);   //  1  4  2  5  6  ^  3
				if (item == 3) iterator.addAfter(7);    //  1  4  2  5  6  3  ^  7
			}
			trace (list.toArray()); // 1,4,2,5,6,3,7

			// Replace during iteration

			list.array = [1, 2, 3];
			iterator = list.iterator() as IOrderedListIterator;
			while (iterator.hasNext()) {
				item = iterator.next();
				trace (item); // 1,2,3

				if (item == 1) iterator.replace(4);   // [4] ^  2  3
				if (item == 2) iterator.replace(5);   //  4 [5] ^  3
				if (item == 3) iterator.replace(6);   //  4  5 [6] ^
			}
			trace (list.toArray()); // 4,5,6

			// Remove during iteration

			list.array = [1, 2, 3, 4, 5];
			iterator = list.iterator() as IOrderedListIterator;
			while (iterator.hasNext()) {
				item = iterator.next();
				trace (item); // 1,2,3,4,5

				if (item == 1) iterator.remove();   //  ^  2  3  4  5
				if (item == 3) iterator.remove();   //  2  ^  4  5
				if (item == 5) iterator.remove();   //  2  4  ^
			}
			trace (list.toArray()); // 2,4

			// Reverse iteration

			list.array = [1, 2, 3, 4, 5];
			iterator = list.iterator() as IOrderedListIterator;
			iterator.end();
			while (iterator.hasPrevious()) {
				trace (iterator.previous()); // 5,4,3,2,1
			}
		}
	}
}
