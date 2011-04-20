/**
 * Copyright 2010 The original author or authors.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.as3commons.collections.fx.events {
	import org.as3commons.collections.framework.ISet;

	/**
	 * Bindable set event.
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>The <code>SetEvent</code> provides additionally to the base collection event:</p>
	 * 
	 * <ul>
	 * <li>Reference to the bindable set.<br />
	 * <code>set</code></li>
	 * <li>An <code>ISetIterator</code><br />
	 * <code>iterator()</code></li>	 * </ul>
	 * 
	 * @author Jens Struwe 29.03.2010
	 * @see CollectionEvent CollectionEvent - Description of the base collection event properties.
	 */
	public class SetEvent extends CollectionEvent {

		/**
		 * The bindable set.
		 */
		public var set : ISet;

		/**
		 * SetEvent constructor.
		 * 
		 * @param theKind The event kind.
		 * @param theSet The set.
		 * @param theItem The affected item in a singular operation.
		 */
		public function SetEvent(
			theKind : String,
			theSet : ISet,
			theItem : * = undefined
		) {
			kind = theKind;
			set = theSet;
			item = theItem;
			
			numItems = kind == RESET ? -1 : 1;
		}

	}
}
