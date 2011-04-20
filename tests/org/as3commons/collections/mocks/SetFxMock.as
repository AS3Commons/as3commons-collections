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
package org.as3commons.collections.mocks {
	import org.as3commons.collections.fx.SetFx;
	import org.as3commons.collections.units.ITestCollection;

	/**
	 * @author Jens Struwe 26.03.2010
	 */
	public class SetFxMock extends SetFx implements
		ITestCollection
	{
		public function SetFxMock() {
			super();
		}
		
		public function addMock(item : *) : void {
			add(item);
		}
	}
}
