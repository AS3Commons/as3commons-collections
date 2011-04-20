package {
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IListIterator;
	import org.as3commons.collections.framework.IOrderedList;
	import org.as3commons.collections.framework.IOrderedListIterator;
	import flash.display.Sprite;

	public class IteratorDowncastExample extends Sprite {

		public function IteratorDowncastExample() {
			var list : IOrderedList = new ArrayList();
			var i : IIterator = list.iterator();
			
			trace ("i", i is IIterator); // true
			trace ("ci", i is ICollectionIterator); // true
			trace ("li", i is IListIterator); // true
			trace ("ali", i is IOrderedListIterator); // true
			
			var ci : ICollectionIterator = list.iterator() as ICollectionIterator;

			trace ("i", ci is IIterator); // true
			trace ("ci", ci is ICollectionIterator); // true
			trace ("li", ci is IListIterator); // true
			trace ("ali", ci is IOrderedListIterator); // true

			var li : IListIterator = list.iterator() as IListIterator;

			trace ("i", li is IIterator); // true
			trace ("ci", li is ICollectionIterator); // true
			trace ("li", li is IListIterator); // true
			trace ("ali", li is IOrderedListIterator); // true

			var ali : IOrderedListIterator = list.iterator() as IOrderedListIterator;

			trace ("i", ali is IIterator); // true
			trace ("ci", ali is ICollectionIterator); // true
			trace ("li", ali is IListIterator); // true
			trace ("ali", ali is IOrderedListIterator); // true
		}
	}
}
