package org.as3commons.collections.utils {

	import flexunit.framework.TestCase;

	import org.as3commons.collections.LinkedSet;
	import org.as3commons.collections.Set;
	import org.as3commons.collections.SortedSet;
	import org.as3commons.collections.framework.ISet;

	import flash.utils.getQualifiedClassName;
	/**
	 * @author John Reeves.
	 */
	public class SetBuilderTest extends TestCase {
		
		public function test_buildSet() : void {
			const result : ISet = SetBuilder.newSet()
				.add("item1")
				.add("item2")
				.build();
				
			assertEquals("Resulting ISet has 2 entries", 2, result.size);
			assertTrue("Resulting ISet has the supplied entry", result.has("item1"));
			assertTrue("Resulting ISet has the supplied entry", result.has("item2"));
			assertEquals("Resulting ISet is an instance of Set", getQualifiedClassName(Set), getQualifiedClassName(result));
		}
		
		public function test_buildLinkedSet() : void {
			const result : ISet = SetBuilder.newLinkedSet()
				.add("item1")
				.build();
				
			assertEquals("Resulting ISet is an instance of LinkedSet", getQualifiedClassName(LinkedSet), getQualifiedClassName(result));
		}
		
		public function test_buildSortedSet() : void {
			const result : ISet = SetBuilder.newSortedSet(new NumericComparator())
				.add(22)
				.add(11)
				.build();
				
			assertEquals("Resulting ISet is an instance of SortedSet", getQualifiedClassName(SortedSet), getQualifiedClassName(result));
		}		

	}
}


