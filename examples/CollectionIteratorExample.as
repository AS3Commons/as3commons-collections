package {
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.ICollectionIterator;
	import flash.display.Sprite;

	public class CollectionIteratorExample extends Sprite {

		public function CollectionIteratorExample() {
			var list : ArrayList = new ArrayList();
			var iterator : ICollectionIterator;
			var item : *;
			
			// ^ = cursor, [n] = current
			
			// Navigation
			
			list.array = [1, 2, 3];
			iterator = list.iterator() as ICollectionIterator;
			
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
			
			// Current item

			iterator = list.iterator() as ICollectionIterator;

			trace (iterator.current);   // undefined
			iterator.next();
			trace (iterator.current);   // 1
			iterator.next();
			trace (iterator.current);   // 2
			iterator.next();
			trace (iterator.current);   // 3
			iterator.next();
			trace (iterator.current);   // undefined

			// Remove

			list.array = [1, 2, 3];
			iterator = list.iterator() as ICollectionIterator;
			
			                          //  ^  1  2  3
			iterator.next();          // [1] ^  2  3
			iterator.next();          //  1 [2] ^  3
			iterator.remove();        //  1  ^  3
			iterator.next();          //  1 [3] ^
			iterator.remove();        //  1  ^
			iterator.remove();        //  1  ^

			// Remove during iteration

			list.array = [1, 2, 3, 4, 5];
			iterator = list.iterator() as ICollectionIterator;
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
			iterator = list.iterator() as ICollectionIterator;
			iterator.end();
			while (iterator.hasPrevious()) {
				trace (iterator.previous()); // 5,4,3,2,1
			}
		}
	}
}
