package {
	import org.as3commons.collections.ArrayList;
	import flash.display.Sprite;

	public class ComparatorImplementationExample extends Sprite {

		public function ComparatorImplementationExample() {
			var list : ArrayList = new ArrayList();
			list.array = [3, 2, 5, 9, 4, 1, 3, 4, 6, 8];
			list.sort(new OddEvenComparator());
			trace (list.toArray()); // 1,3,3,5,9,2,4,4,6,8
		}
	}
}

import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.utils.UncomparableType;

internal class OddEvenComparator implements IComparator {

	public function compare(item1 : *, item2 : *) : int {
		if (isNaN(item1)) throw new UncomparableType(Number, item1);
		if (isNaN(item2)) throw new UncomparableType(Number, item2);
		
		// sort numeric if both items odd or even
		if ((item1 + item2) % 2 == 0) {
			if (item1 < item2) return -1;
			if (item1 > item2) return 1;
			return 0;
		}
		
		// sort odd numbers before even numbers
		if (item1 % 2) return -1; // item1 odd, item2 even
		return 1; // item1 even, item2 odd
	}
}
