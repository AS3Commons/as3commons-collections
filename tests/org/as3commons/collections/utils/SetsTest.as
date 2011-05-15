package org.as3commons.collections.utils {

	import flexunit.framework.TestCase;

	import org.as3commons.collections.LinkedSet;
	import org.as3commons.collections.Set;
	import org.as3commons.collections.SortedSet;
	import org.as3commons.collections.framework.IMap;
	import org.as3commons.collections.framework.ISet;
	import org.as3commons.collections.testhelpers.CollectionTest;

	import flash.utils.getQualifiedClassName;

	public class SetsTest extends TestCase {

		private var theSet: ISet;
		
		override public function setUp() : void {
			theSet = new LinkedSet();
		}

		/*
		 * Creation
		 */

		public function test_newSet() : void {
			
			var map : IMap = Maps.newMap(5, 5);
			var a : Array = [3, 3];

			// theSet of items to add

			var theSet : Set = Sets.newSet(2, Args.from(map), 1, 1, Args.from(a));
			assertTrue(theSet is Set);
			assertEquals(4, theSet.size);
			assertTrue(CollectionTest.itemsMatch(theSet, [2, 5, 1, 3]));
			
			// no item

			theSet = Sets.newSet();
			assertTrue(theSet is Set);
			assertEquals(0, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, []));
		}

		public function test_newLinkedSet() : void {
			
			var map : IMap = Maps.newMap(5, 5);
			var a : Array = [3, 3];

			// theSet of items to add

			var theSet : LinkedSet = Sets.newLinkedSet(2, Args.from(map), 1, 1, Args.from(a));
			assertTrue(theSet is LinkedSet);
			assertEquals(4, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, [2, 5, 1, 3]));
			
			// no item

			theSet = Sets.newLinkedSet();
			assertTrue(theSet is LinkedSet);
			assertEquals(0, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, []));
		}

		public function test_newSortedSet() : void {
			
			var map : IMap = Maps.newMap(5, 5);
			var a : Array = [3, 3];

			// even theSet of items to add

			var theSet : SortedSet = Sets.newSortedSet(new NumericComparator(), 2, Args.from(map), 1, Args.from(a));
			assertTrue(theSet is SortedSet);
			assertEquals(4, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, [1, 2, 3, 5]));
			
			// no item

			theSet = Sets.newSortedSet(new NumericComparator());
			assertTrue(theSet is SortedSet);
			assertEquals(0, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, []));
		}

		/*
		 * Clone
		 */

		public function test_clone_returnsCopy() : void {
			theSet.add(1);
			theSet.add(2);

			var filter : Function = function(key : int) : Boolean {
				return (key % 2 == 0);
			};

			// no filter
			
			var clone : ISet = Sets.clone(theSet);
			assertTrue (theSet !== clone);

			// only item filter

			clone = Sets.clone(theSet, filter);
			assertTrue (theSet !== clone);

			// both filters

			clone = Sets.clone(theSet, filter);
			assertTrue (theSet !== clone);
		}

		public function test_clone_filters() : void {
			theSet.add(1);
			theSet.add(2);
			theSet.add(3);
			theSet.add(4);
			theSet.add(5);
			theSet.add(6);
			theSet.add(7);
			theSet.add(8);
			theSet.add(9);
			theSet.add(10);
			theSet.add(11);
			theSet.add(12);
			
			var filter : Function = function(key : int) : Boolean {
				return (key % 2 == 0);
			};

			// no filter
			
			var clone : ISet = Sets.clone(theSet);
			assertEquals(12, clone.size);
			assertEquals(getQualifiedClassName(theSet), getQualifiedClassName(clone));
			assertTrue(CollectionTest.itemsEqual(clone, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));

			// filter

			clone = Sets.clone(theSet, filter);
			assertEquals(6, clone.size);
			assertEquals(getQualifiedClassName(theSet), getQualifiedClassName(clone));
			assertTrue(CollectionTest.itemsEqual(clone, [2, 4, 6, 8, 10, 12]));

		}
		
		public function test_clone_type_and_order() : void {

			// array theSet
			theSet = new LinkedSet();
			populate(theSet);
			var clone : ISet = Sets.clone(theSet);
			assertTrue(clone is LinkedSet);
			assertTrue(CollectionTest.itemsEqual(clone, [3, 2, 4, 1]));

			// sorted theSet
			theSet = new SortedSet(new NumericComparator());
			populate(theSet);
			clone = Sets.clone(theSet);
			assertTrue(clone is SortedSet);
			assertTrue(CollectionTest.itemsEqual(clone, [1, 2, 3, 4]));
			
			function populate(theSet : ISet) : void {
				theSet.add(3);
				theSet.add(2);
				theSet.add(4);
				theSet.add(1);
			}
			
		}

		public function test_copy() : void {
			theSet.add(1);
			theSet.add(2);
			theSet.add(3);
			theSet.add(4);
			theSet.add(5);
			theSet.add(6);
			theSet.add(7);
			theSet.add(8);
			theSet.add(9);
			theSet.add(10);
			theSet.add(11);
			theSet.add(12);
			
			var filter : Function = function(key : int) : Boolean {
				return (key % 2 == 0);
			};

			// no filter
			
			var destination : ISet = new LinkedSet();
			Sets.copy(theSet, destination);
			assertEquals(12, destination.size);
			assertEquals(getQualifiedClassName(theSet), getQualifiedClassName(destination));
			assertTrue(CollectionTest.itemsEqual(destination, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));

			// filter

			destination = new LinkedSet();
			Sets.copy(theSet, destination, filter);
			assertEquals(6, destination.size);
			assertEquals(getQualifiedClassName(theSet), getQualifiedClassName(destination));
			assertTrue(CollectionTest.itemsEqual(destination, [2, 4, 6, 8, 10, 12]));

		}
		
		/*
		 * Population
		 */

		// from array
		
		public function test_addFromArray() : void {
			// even number of arguments

			var theSet : ISet = new LinkedSet();
			var numItems : uint = Sets.addFromArray(theSet, [1, 2, 3, 4, 5]);
			assertEquals(5, numItems);
			assertEquals(5, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, [1, 2, 3, 4, 5]));

			// no argument

			theSet = new LinkedSet();
			numItems = Sets.addFromArray(theSet, []);
			assertEquals(0, numItems);
			assertEquals(0, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, []));
		}		

		public function test_addFromArray_null() : void {
			var theSet : LinkedSet = new LinkedSet();
			var numItems : uint = Sets.addFromArray(theSet, null);
			assertEquals(0, numItems);
			assertEquals(0, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, []));
		}
		
		public function test_addFromArray_entries_kept() : void {
			var theSet : LinkedSet = new LinkedSet();
			theSet.add(1);

			var source : Array = [2, 3];
			
			var numItems : uint = Sets.addFromArray(theSet, source);
			assertEquals(2, numItems);
			assertEquals(3, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, [1, 2, 3]));
		}

		public function test_addFromArray_mixed_array() : void {
			var sourceSet : LinkedSet = new LinkedSet();
			sourceSet.add(2);
			sourceSet.add(3);
			sourceSet.add(4);

			var sourceMap : IMap = Maps.newLinkedMap(6, 6, 7, 7);
			var sourceArray : Array = [8, 8];

			var source : Array = [
				1, 1,
				Args.from(sourceSet),
				5, 5,
				Args.from(sourceMap),
				Args.from(sourceArray),
				9, 9
			];

			var theSet : LinkedSet = new LinkedSet();
			var numItems : uint = Sets.addFromArray(theSet, source);

			assertEquals(9, numItems);
			assertEquals(9, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, [1, 2, 3, 4, 5, 6, 7, 8, 9]));
		}

		// from collection

		public function test_addFromCollection() : void {
			var source : LinkedSet = new LinkedSet();
			source.add(1);
			source.add(2);
			
			var theSet : LinkedSet = new LinkedSet();
			var numItems : uint = Sets.addFromCollection(theSet, source);
			
			assertEquals(2, numItems);
			assertEquals(2, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, [1, 2]));
		}		
		
		public function test_addFromCollection_null() : void {
			var theSet : LinkedSet = new LinkedSet();
			var numItems : uint = Sets.addFromCollection(theSet, null);
			assertEquals(0, numItems);
			assertEquals(0, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, []));
		}
		
		public function test_addFromCollection_entries_kept() : void {
			var theSet : LinkedSet = new LinkedSet();
			theSet.add(1);

			var source : LinkedSet = new LinkedSet();
			source.add(2);

			var numItems : uint = Sets.addFromCollection(theSet, source);

			assertEquals(1, numItems);
			assertEquals(2, theSet.size);
			assertTrue(CollectionTest.itemsEqual(theSet, [1, 2]));
		}
		
		// from args

		public function test_addFromArgs() : void {
			// even number of arguments

			var theSet : ISet = new LinkedSet();
			Sets.addFromArgs(theSet, 1, 2, 3, 4, 5);
			assertTrue(CollectionTest.itemsEqual(theSet, [1, 2, 3, 4, 5]));

			// no argument

			theSet = new LinkedSet();
			Sets.addFromArgs(theSet);
			assertTrue(CollectionTest.itemsEqual(theSet, []));
		}

	}
}

