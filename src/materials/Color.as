package materials
{
	/**
	 * 
	 * @author Polar
	 * @date:2015-12-1
	 */
	public class Color
	{
		// ======================================================================
		//	Constants
		// ----------------------------------------------------------------------	
		public static const black:Color 	= new Color(0,0,0);
		public static const white:Color 	= new Color(1,1,1);
		public static const red:Color 		= new Color(1,0,0);
		public static const green:Color 	= new Color(0,1,0);
		public static const blue:Color 		= new Color(0,0,1);
		
		// ======================================================================
		//	Properties
		// ----------------------------------------------------------------------
		public var r:Number;
		public var g:Number;
		public var b:Number;
		
		// ======================================================================
		//	Constructor
		// ----------------------------------------------------------------------
		public function Color(r:Number,g:Number,b:Number)
		{
			this.r = Math.min(1,r);
			this.g = Math.min(1,g);
			this.b = Math.min(1,b);
		}
		
		// ======================================================================
		//	Getters/Setters
		// ----------------------------------------------------------------------
		public function get hex():uint{
			return (int(r * 0xFF) << 16) | (int(g * 0xFF) << 8) | (int(b * 0xFF));
		}
		
		// ======================================================================
		//	Methods
		// ----------------------------------------------------------------------
		public function clone():Color{
			return new Color(r,g,b);
		}
		
		public function add(c:Color):Color{
			return new Color(r + c.r,g + c.g,b + c.b);
		}
		
		public function multiply(val:Number):Color{
			return new Color(r * val,g * val,b * val);
		}
		
		public function modulate(c:Color):Color{
			return new Color(r * c.r,g * c.g,b * c.b);
		}
	}
}