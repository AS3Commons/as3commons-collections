package org.as3commons.collections.utils {

	import flexunit.framework.TestCase;

	import org.as3commons.collections.LinkedSet;
	import org.as3commons.collections.Set;
	import org.as3commons.collections.SortedSet;
	import org.as3commons.collections.framework.ISet;
	import org.as3commons.collections.testhelpers.CollectionTest;

	import flash.utils.getQualifiedClassName;
	/**
	 * @author John Reeves.
	 */
	public class SetBuilderTest extends TestCase {
		
		public function test_buildSet() : void {
			const result : ISet = SetBuilder.set()
				.add("item1")
				.add("item2")
				.build();
				
			assertEquals("Resulting ISet has 2 entries", 2, result.size);
			assertTrue("Resulting ISet has the supplied entry", result.has("item1"));
			assertTrue("Resulting ISet has the supplied entry", result.has("item2"));
			assertEquals("Resulting ISet is an instance of Set", getQualifiedClassName(Set), getQualifiedClassName(result));
		}
		
		public function test_buildSet_addAll_overlapOfValues() : void {
			const anotherSet : ISet = new Set();
			anotherSet.add("item1");
			anotherSet.add("item2");
			
			const result : ISet = SetBuilder.set()
				.add("item1")			
				.addAll(anotherSet)		 
				.add("item3")
				.build();
				
			assertEquals("Resulting ISet has 3 entries due to overlaps", 3, result.size);
		}
		
		public function test_buildLinkedSet() : void {
			const result : ISet = SetBuilder.linkedSet()
				.add("item1")
				.build();
				
			assertEquals("Resulting ISet is an instance of LinkedSet", getQualifiedClassName(LinkedSet), getQualifiedClassName(result));
		}
		
		public function test_buildSortedSet() : void {
			const result : ISet = SetBuilder.sortedSet(new NumericComparator())
				.add(22)
				.add(11)
				.build();
				
			assertEquals("Resulting ISet is an instance of SortedSet", getQualifiedClassName(SortedSet), getQualifiedClassName(result));
		}		

		public function test_addMany() : void {
			// multiple arguments

			var theSet : ISet = SetBuilder.linkedSet()
				.addMany(1, 2, 3, 4, 5)
				.build();
				
			assertTrue(CollectionTest.itemsEqual(theSet, [1, 2, 3, 4, 5]));

			// single argument

			theSet = SetBuilder.linkedSet()
				.addMany(1)
				.build();

			assertTrue(CollectionTest.itemsEqual(theSet, [1]));

			// no argument

			theSet = SetBuilder.linkedSet()
				.addMany()
				.build();
				
			assertTrue(CollectionTest.itemsEqual(theSet, []));
		}

	}
}


