package Engine.Utils
{
	import flash.events.MouseEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageQuality;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	public class  CommonUtils
	{
		// helpers
		static public const aPI: Number = 1 / Math.PI;
		static public const _180PI: Number = 180 / Math.PI;
		static public const _PI180: Number = Math.PI / 180;
		
		static protected var fMatrix: Matrix = null;
		static protected var fBounds: Rectangle = null;
		static protected var fAdditionalBound: int = 0;
		
		static public function GetButtonByDef(aObjectContainer: DisplayObjectContainer, aButtonDef: Class, aRecursive: Boolean): SimpleButton
		{
			var Btn: SimpleButton = null;
			for (var i: int = 0; i < aObjectContainer.numChildren; i++)
			{
				if ((aObjectContainer.getChildAt(i) is aButtonDef) && (aObjectContainer.getChildAt(i) is SimpleButton))
					return SimpleButton(aObjectContainer.getChildAt(i));
					
				if (aRecursive && (aObjectContainer.getChildAt(i) is DisplayObjectContainer))
				{
					Btn = GetButtonByDef(DisplayObjectContainer(aObjectContainer.getChildAt(i)), aButtonDef, aRecursive);
					if (Btn)
						return Btn;
				}
			}
			return null;
		}
		
		static public function GetSpriteByDef(aObjectContainer: DisplayObjectContainer, aSpriteDef: Class, aRecursive: Boolean): Sprite
		{
			var Obj: Sprite = null;
			for (var i: int = 0; i < aObjectContainer.numChildren; i++)
			{
				if ((aObjectContainer.getChildAt(i) is aSpriteDef) && (aObjectContainer.getChildAt(i) is Sprite))
					return Sprite(aObjectContainer.getChildAt(i));
					
				if (aRecursive && (aObjectContainer.getChildAt(i) is DisplayObjectContainer))
				{
					Obj = GetSpriteByDef(DisplayObjectContainer(aObjectContainer.getChildAt(i)), aSpriteDef, aRecursive);
					if (Obj)
						return Obj;
				}
			}
			return null;
		}		
		
		static public function GetAnyTextField(aObjectContainer: DisplayObjectContainer): TextField
		{
			for (var i: int = 0; i < aObjectContainer.numChildren; i++)
				if (aObjectContainer.getChildAt(i) is TextField)
					return TextField(aObjectContainer.getChildAt(i));
			return null;
		}
		
		static public function RemoveAllChildren(...aContainers): void
		{
			var aContainer: DisplayObjectContainer = null; 
			for(var i: int = 0; i < aContainers.length; i++)
				if(aContainers[i] is DisplayObjectContainer)
				{
					aContainer = aContainers[i] as DisplayObjectContainer;
					if(aContainer.numChildren > 0)
					{
						while(aContainer.numChildren > 0)
							aContainer.removeChildAt(0);
					}
				}
		}
		
		static public function RemoveCurrentChildren(...aChildren): void
		{
			for(var i: int = 0; i < aChildren.length; i++)
				if((aChildren[i] is DisplayObject) && DisplayObject(aChildren[i]).parent)
					(DisplayObject(aChildren[i]).parent as DisplayObjectContainer).removeChild( aChildren[i] );
		}
		
		static public function GetRotatedBoundRect(aRect: Rectangle, aAngle: Number): Rectangle
		{
			var ResultRect: Rectangle = new Rectangle;
			var leftTop    : Point = new Point(aRect.left, aRect.top);
			var leftBottom : Point = new Point(aRect.left, aRect.bottom);
			var rightTop   : Point = new Point(aRect.right, aRect.top);
			var rightBottom: Point = new Point(aRect.right, aRect.bottom);
			
			fMatrix.identity();
			fMatrix.rotate(aAngle);
			
			leftTop     = fMatrix.transformPoint(leftTop);
			leftBottom  = fMatrix.transformPoint(leftBottom);
			rightTop    = fMatrix.transformPoint(rightTop);
			rightBottom = fMatrix.transformPoint(rightBottom);
			
			ResultRect.left   = Math.min(leftTop.x, leftBottom.x, rightTop.x, rightBottom.x);
			ResultRect.top    = Math.min(leftTop.y, leftBottom.y, rightTop.y, rightBottom.y);
			ResultRect.right  = Math.max(leftTop.x, leftBottom.x, rightTop.x, rightBottom.x);
			ResultRect.bottom = Math.max(leftTop.y, leftBottom.y, rightTop.y, rightBottom.y);
			
			return ResultRect;
		}
		
		/**
		 * @param	aSource	 изображение, которое мы растеризуем
		 * @param	aDest	контейнер, куда рисуем
		 * @param	aRemoveChildren	удалять ли элементы из aDest'а
		 */			
		static public function RasterizeToSprite(aSource: DisplayObject, aDest: DisplayObjectContainer, aRemoveChildren: Boolean = true, aZeroAngle: Boolean = true): void
		{
			if (aSource && aDest)
			{
				var image: Bitmap = RasterizeToBitmap(aSource);
				
				if (aRemoveChildren)
					RemoveAllChildren(aDest);
			
				aDest.addChild(image);
				aDest.x = aSource.x;
				aDest.y = aSource.y;
				aDest.scaleX = 1;
				aDest.scaleY = 1;
				aDest.rotation = 0;
			}
			else if (!aSource)
				trace('CommonUtils.RasterizeToSprite: source == null');
			else if (!aDest)
				trace('CommonUtils.RasterizeToSprite: dest == null');
		}
		
		static public function RasterizeToBitmap(aSource: DisplayObject, aUseAppScale: Boolean = true): Bitmap
		{
			if (aSource)
			{
				var imageBD: BitmapData = RasterizeToBitMapData(aSource, true, aUseAppScale);
				var image: Bitmap = new Bitmap(imageBD);
				
				image.x = Math.floor(fMatrix.tx);
				image.y = Math.floor(fMatrix.ty);
				
				return image;
			}
			else if (!aSource)
				trace('CommonUtils.RasterizeToSprite: source == null');
				
			return null;
		}
		
		static public function RasterizeToBitMapData(aSource: DisplayObject, aRoundCoords: Boolean = false, aUseAppScale: Boolean = true): BitmapData
		{
			if (!fMatrix)
				fMatrix = new Matrix();
			
			var sclX: Number = aSource.scaleX;
			var sclY: Number = aSource.scaleY;
			if(aUseAppScale)
			{
				aSource.scaleX *= AppScales.GetAppScale();
				aSource.scaleY *= AppScales.GetAppScale();
			}
			
			fBounds = aSource.getRect(aSource);
			fBounds.left   = fBounds.left   * aSource.scaleX - fAdditionalBound;
			fBounds.right  = fBounds.right  * aSource.scaleX + fAdditionalBound;
			fBounds.top    = fBounds.top    * aSource.scaleY - fAdditionalBound;
			fBounds.bottom = fBounds.bottom * aSource.scaleY + fAdditionalBound;
			if(aRoundCoords)
			{
				fBounds.left = Math.floor(fBounds.left);
				fBounds.top = Math.floor(fBounds.top);
				fBounds.right = Math.ceil(fBounds.right);
				fBounds.bottom = Math.ceil(fBounds.bottom);
			}
			fBounds = GetRotatedBoundRect(fBounds, aSource.rotation * Math.PI / 180);
			
			var result: BitmapData = new BitmapData(fBounds.right - fBounds.left, 
													fBounds.bottom - fBounds.top, true, 0x00FFFFFF);
			
			fMatrix.identity();
			fMatrix.scale(aSource.scaleX, aSource.scaleY);
			fMatrix.rotate(aSource.rotation * Math.PI / 180);
			fMatrix.translate( -fBounds.left, -fBounds.top);
			
			result.draw(aSource, fMatrix);
			
			fMatrix.identity();
			fMatrix.translate(fBounds.left, fBounds.top);
			aSource.scaleX = sclX;
			aSource.scaleY = sclY;			
			
			//fMatrix.rotate( -aSource.rotation * Math.PI / 180); // я добавил fInitialPosition в BaseGameObject, и теперь в повороте матрицы и картинки нет необходимости
			
			return result;
		}
		
		static public function RasterizeMovieClipToBitmapsVector(aSource: MovieClip, aTarget: Vector.<Bitmap>, aFramesCount: int): void
		{
			var count: int = Math.min(aFramesCount, aSource.totalFrames);
			for(var i: int = 0; i < count; i++)
			{
				aSource.gotoAndStop( i + 1 );
				aTarget.push( RasterizeToBitmap( aSource ) );
			}
		}
		
		static public function CreateRasterizedSprite(aSource: DisplayObject): Sprite
		{
			var result: Sprite = new Sprite();
			RasterizeToSprite(aSource, result);
			return result;
		}
		
		static public function GraphicsClear(...aSprites): void
		{
			for(var i: int = 0; i < aSprites.length; i++)
				if(aSprites[i] is Sprite)
					(aSprites[i] as Sprite).graphics.clear();
		}
		
		static public function RasterizeSelfSeveral(...aSprites): void
		{
			for(var i: int = 0; i < aSprites.length; i++)
				if(aSprites[i] is DisplayObjectContainer)
					RasterizeToSprite(aSprites[i] as DisplayObjectContainer, aSprites[i] as DisplayObjectContainer);
		}
		
		static public function GetRasterizationMatrix(): Matrix
		{
			return fMatrix;
		}
		
		static public function SetSmooth(aContainer: DisplayObjectContainer, aSmooth: Boolean = true, aSmoothChildren: Boolean = true): void
		{
			for(var i: int = 0; i < aContainer.numChildren; i++)
			{
				if(aContainer.getChildAt(i) is Bitmap)
					Bitmap(aContainer.getChildAt(i)).smoothing = aSmooth;
				
				if(aSmoothChildren && (aContainer.getChildAt(i) is DisplayObjectContainer))
					SetSmooth(DisplayObjectContainer(aContainer.getChildAt(i)), aSmooth, aSmoothChildren);
			}
		}
		
		static public function CopyToBitmap(aSourceBitmap: Bitmap, aDestBitmap: Bitmap): Bitmap
		{
			var result: Bitmap = null;
			if(aDestBitmap)
			{
				result = aDestBitmap;
				result.bitmapData = aSourceBitmap.bitmapData;
			}
			else
				result = new Bitmap( aSourceBitmap.bitmapData );
			return result;
		}
		
		static public function CreateBitmapTo(aSourceBitmap: Bitmap, aDestContainer: DisplayObjectContainer): void
		{
			var bitmap: Bitmap = CopyToBitmap(aSourceBitmap, null);
			bitmap.x = aSourceBitmap.x;
			bitmap.y = aSourceBitmap.y;
			aDestContainer.addChild( bitmap );
		}
		
		static public function StopMovieClip(aObject: DisplayObjectContainer, aRecursive: Boolean = true): void
		{
			if (aObject is MovieClip)
				MovieClip(aObject).stop();
			
			for (var i: int = 0; i < aObject.numChildren; i++)
				if (aObject.getChildAt(i) is DisplayObjectContainer)
					StopMovieClip(DisplayObjectContainer(aObject.getChildAt(i)), aRecursive);
		}
		
		static public function PlayMovieClip(aObject: DisplayObjectContainer, aRecursive: Boolean = true): void
		{
			if (aObject is MovieClip)
				MovieClip(aObject).play();
			
			for (var i: int = 0; i < aObject.numChildren; i++)
				if (aObject.getChildAt(i) is DisplayObjectContainer)
					PlayMovieClip(DisplayObjectContainer(aObject.getChildAt(i)), aRecursive);
		}
		
		static public function IsContainStr(aObject: Object, ...aStrings): Boolean
		{
			var str: String = String(aObject);
			for (var i:int = 0; i < aStrings.length; i++ )
				if (str.indexOf(aStrings[i]) > 0)
					return true;
			return false;
		}
		
		static public function IsObjectInList(aObject: Object, ...aList): Boolean
		{
			for (var i: int = 0; i < aList.length; i++)
				if (aObject == aList[i])
					return true;
			return false;
		}
		
		static public function Random(): Number
		{
			return Math.random();
		}
	}
	
}