package materials
{
	/**
	 * 
	 * @author Polar
	 * @date:2015-12-1
	 */
	import flash.geom.Vector3D;
	
	public class PhongMaterial implements IMaterial
	{
		// ======================================================================
		//	Constants
		// ----------------------------------------------------------------------	
		
		// ======================================================================
		//	Properties
		// ----------------------------------------------------------------------
		private var _diffuse:Color;
		private var _specular:Color;
		private var _shininess:Number;
		private var _reflectiveness:Number;
		
		public var lightDir:Vector3D = new Vector3D(1,1,1);
		public var lightColor:Color = Color.white;
		// ======================================================================
		//	Constructor
		// ----------------------------------------------------------------------
		public function PhongMaterial(diffuse:Color,specular:Color,shininess:Number,reflectiveness:Number)
		{
			_diffuse = diffuse;
			_specular = specular;
			_shininess = shininess;
			_reflectiveness = reflectiveness;
		}
		
		public function sample(ray:Ray, position:Vector3D, normal:Vector3D):Color
		{
			lightDir.normalize();
			var NdotL:Number = normal.dotProduct(lightDir);
			var H:Vector3D = lightDir.subtract(ray.direction);
			H.normalize();
			var NdotH:Number = normal.dotProduct(H);
			var diffuseTerm:Color = _diffuse.multiply(Math.max(0,NdotL));
			var specularTerm:Color = _specular.multiply(Math.pow(Math.max(0,NdotH),_shininess));
			return lightColor.modulate(diffuseTerm.add(specularTerm));
		}
		
		// ======================================================================
		//	Getters/Setters
		// ----------------------------------------------------------------------
		
		// ======================================================================
		//	Methods
		// ----------------------------------------------------------------------
		
		public function get reflectiveness():Number
		{
			return _reflectiveness;
		}
		
	}
}