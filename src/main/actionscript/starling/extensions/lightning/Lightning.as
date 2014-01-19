package starling.extensions.lightning 
{
	import starling.display.graphics.Stroke;

	public class Lightning extends LightningBase 
	{
		protected var _stroke:Stroke = null;
		
		public function Lightning(color:uint = 0xFFFFFF, thickness:Number = 2, generation:uint = 0, isPooled:Boolean = false) 
		{ 
			super(color, thickness, generation, isPooled);
		}
		
		public function update():void 
		{
			if ( _stroke == null )
			{
				_stroke = new Stroke();
				addChild(_stroke);
			}
			else	
				_stroke.clear();
			
			updateBase(_stroke);
		}
	}

}