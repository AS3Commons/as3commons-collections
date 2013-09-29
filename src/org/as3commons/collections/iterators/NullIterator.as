package org.as3commons.collections.iterators {
	import org.as3commons.collections.framework.IIterator;

	/**
	 * Null iterator.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>NullIterator</code> is an <code>IIterator</code> that do not iterate over any data structure.</p>
	 * 
	 * <p>It allows the creation of an <code>IITerable</code> abstract class with concrete subclasses that cannot be iterated.
	 * The typical use case is a regular Composite pattern implementation. The (abstract) Component class implements
	 * <code>IIterable</code> but any subclasses may not contain iterable elements. The regular inplementation of such a subclass
	 * suggests to inherit the <code>iterator()</code> method from the abstract class which throws an error. 
	 * Therefore, given an object of the abstract class, it is not possible to iterate safely over it since it may throw errors.
	 * 
	 * <p>Another similar example is trees. They are made of nodes and leaves and the latter do not contain subelements. It is
	 * currently not possible to make such a structure iterable with a <code>RecursiveIterator</code> iterator without this
	 * <code>NullIterator</code> class.</p>
	 * 
	 * @author Sébastien Varlet 29.09.2013
	 * @see org.as3commons.collections.framework.IIterator IIterator interface - Description of the IIterator interface.
	 */
	public class NullIterator implements IIterator {
		/**
		 * @inheritDoc
		 */
		public function hasNext() : Boolean {
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function next() : * {
			return undefined;
		}
	}
}
