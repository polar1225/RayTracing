package materials
{
	import flash.geom.Vector3D;

	/**
	 * 
	 * @author Polar
	 * @date:2015-12-1
	 */
	public interface IMaterial
	{
		function sample(ray:Ray,position:Vector3D,normal:Vector3D):Color;
		
		function get reflectiveness():Number;
	}
}