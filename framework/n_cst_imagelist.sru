HA$PBExportHeader$n_cst_imagelist.sru
forward
global type n_cst_imagelist from nonvisualobject
end type
end forward

global type n_cst_imagelist from nonvisualobject autoinstantiate
end type

type prototypes
PUBLIC FUNCTION ULong LoadImage (ULong hInst, string lpsz, Long un1, Long n1, Long n2, Long un2) LIBRARY "user32.dll" ALIAS FOR "LoadImageW"
PUBLIC FUNCTION ULong LoadIcon(ULong hInstance, String lpIconName) LIBRARY "user32.dll" ALIAS FOR "LoadIconW"
PUBLIC FUNCTION ULong ImageList_Create (Long cx, Long cy, Long flags, Long cInitial, Long cGrow) LIBRARY "comctl32.dll" 
PUBLIC FUNCTION ULong ImageList_Destroy (ULong himl) LIBRARY "comctl32.dll" 
PUBLIC FUNCTION ULong ImageList_Add (ULong himl, ULong hbmImage, Long hbmMask) LIBRARY "comctl32.dll"

PUBLIC FUNCTION Long DeleteObject(Long hObject) LIBRARY"gdi32.dll"
PUBLIC FUNCTION Long DestroyCursor(Long hCursor) LIBRARY "user32.dll" 
PUBLIC FUNCTION Long DestroyIcon(Long hIcon) LIBRARY "user32.dll"

PUBLIC FUNCTION Long GetLastError() LIBRARY "kernel32.dll"
end prototypes

type variables
CONSTANT LONG SMALL = 16
CONSTANT LONG MEDIUM = 24
CONSTANT LONG LARGE = 32
CONSTANT LONG XLARGE = 48

CONSTANT LONG IMAGE_BITMAP = 0
CONSTANT LONG IMAGE_ICON = 1
CONSTANT LONG IMAGE_CURSOR = 2

ULong il_imagelistsmall
ULong il_imagelistmedium
ULong il_imagelistlarge
ULong il_imagelistxlarge

CONSTANT LONG LR_LOADFROMFILE = 16
CONSTANT LONG ILC_COLOR32 = 32
end variables

forward prototypes
public function integer of_addimage (string as_image)
public function ulong of_getimagelist (long al_size)
end prototypes

public function integer of_addimage (string as_image);ULong ll_null, ll_return
ULong ll_imagesmall, ll_imagemedium, ll_imagelarge, ll_imagexlarge
Long ll_imagetype

SetNull(ll_null)

CHOOSE CASE Lower(Right(as_image, 3))
	CASE 'ico'
		ll_imagetype = IMAGE_ICON
	CASE 'cur'
		ll_imagetype = IMAGE_CURSOR
	CASE ELSE
		ll_imagetype = IMAGE_BITMAP
END CHOOSE

ll_imagesmall = LoadImage (ll_null, as_image, ll_imagetype, SMALL, SMALL, LR_LOADFROMFILE)
ll_imagemedium = LoadImage (ll_null, as_image, ll_imagetype, MEDIUM, MEDIUM, LR_LOADFROMFILE)
ll_imagelarge = LoadImage (ll_null, as_image, ll_imagetype, LARGE, LARGE, LR_LOADFROMFILE)
ll_imagexlarge = LoadImage (ll_null, as_image, ll_imagetype, XLARGE, XLARGE, LR_LOADFROMFILE)

ll_return = ImageList_Add (il_imagelistsmall, ll_imagesmall, 0)
ll_return = ImageList_Add (il_imagelistmedium, ll_imagemedium, 0)
ll_return = ImageList_Add (il_imagelistlarge, ll_imagelarge, 0)
ll_return = ImageList_Add (il_imagelistxlarge, ll_imagexlarge, 0)

CHOOSE CASE ll_imagetype
	CASE IMAGE_ICON
		DestroyIcon(ll_imagesmall)
		DestroyIcon(ll_imagemedium)
		DestroyIcon(ll_imagelarge)
		DestroyIcon(ll_imagexlarge)
	CASE IMAGE_CURSOR
		DestroyCursor(ll_imagesmall)
		DestroyCursor(ll_imagemedium)
		DestroyCursor(ll_imagelarge)
		DestroyCursor(ll_imagexlarge)
	CASE IMAGE_BITMAP
		DeleteObject(ll_imagesmall)
		DeleteObject(ll_imagemedium)
		DeleteObject(ll_imagelarge)
		DeleteObject(ll_imagexlarge)
END CHOOSE

RETURN 1
end function

public function ulong of_getimagelist (long al_size);CHOOSE CASE al_size
	CASE SMALL
		RETURN il_imagelistsmall
	CASE MEDIUM
		RETURN il_imagelistmedium
	CASE LARGE
		RETURN il_imagelistlarge
	CASE XLARGE
		RETURN il_imagelistxlarge
END CHOOSE

RETURN 1
end function

on n_cst_imagelist.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_imagelist.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;ImageList_Destroy (il_imagelistsmall)
ImageList_Destroy (il_imagelistmedium)
ImageList_Destroy (il_imagelistlarge)
ImageList_Destroy (il_imagelistxlarge)
end event

event constructor;il_imagelistsmall = ImageList_Create (SMALL, SMALL, ILC_COLOR32, 0, 1024)
il_imagelistmedium = ImageList_Create (MEDIUM, MEDIUM, ILC_COLOR32, 0, 1024)
il_imagelistlarge = ImageList_Create (LARGE, LARGE, ILC_COLOR32, 0, 1024)
il_imagelistxlarge = ImageList_Create (XLARGE, XLARGE, ILC_COLOR32, 0, 1024)
end event

