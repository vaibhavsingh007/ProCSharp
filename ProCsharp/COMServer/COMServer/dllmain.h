// dllmain.h : Declaration of module class.

class CCOMServerModule : public ATL::CAtlDllModuleT< CCOMServerModule >
{
public :
	DECLARE_LIBID(LIBID_COMServerLib)
	DECLARE_REGISTRY_APPID_RESOURCEID(IDR_COMSERVER, "{0903466B-F2D3-4E34-B5FA-F8F72B045165}")
};

extern class CCOMServerModule _AtlModule;
