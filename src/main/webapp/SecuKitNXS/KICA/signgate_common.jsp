<!--
	Filename : signgate_common.jsp
-->

<%@ page import="signgate.crypto.util.*" %>

<%!

	public static final String CRLCacheDirectory = "D:\\NCIA\\workspace\\openworks\\3.0\\openworks-3.0\\src\\main\\webapp\\SecuKitNXS\\CRL";
	//public static final String ServerCertPath = "D:\\SG_ToolKit\\cert\\pem\\";
	//public static final String ServerCertPath = "D:\\SG_ToolKit\\cert\\";
	//public static final String ServerCertPath = "D:\\SG_ToolKit\\cert\\2\\";
	public static final String ServerCertPath = "D:\\NCIA\\workspace\\openworks\\3.0\\openworks-3.0\\src\\main\\webapp\\SecuKitNXS\\cert\\";
	public static final String ServerSignCertFile = ServerCertPath + "signCert.der";	// ���� ���ڼ���� ������ ���ϸ�
	public static final String ServerSignKeyFile = ServerCertPath + "signPri.key";		// ���� ���ڼ���� ����Ű ���ϸ�
	public static final String ServerKmCertFile = ServerCertPath + "kmCert.der";		// ���� ��ȣȭ�� ������ ���ϸ�
	public static final String ServerKmKeyFile = ServerCertPath + "kmPri.key";			// ���� ��ȣȭ�� ����Ű ���ϸ�
	//public static final String ServerKeyPassword = "a123456A"; // ���� ������(����Ű) ��й�ȣ
	//public static final String ServerKeyEncPasswordPath = ServerCertPath + "encPasswd";	// ��ȣȭ�� ���� ������(����Ű) ��й�ȣ
	public static final String ServerKeyEncPasswordPath = ServerCertPath + "EncPasswd";	// ��ȣȭ�� ��
	// ��ĪŰ ��ȣȭ �˰��� ���� ����
	public static final String ServerEncryptAlg = "SEED/CBC";		// SEED/CBC or ARIA/CBC


	// ����� ������ ��å OID ����Ʈ (���� ������ OID ����Ʈ)
	public static final String[] AllowedPolicyOIDs = {
		"1.2.410.200004.5.2.1.2",	//�ѱ���������(����)
		"1.2.410.200004.5.2.1.1",	//�ѱ���������(����)
		"1.2.410.200004.5.1.1.5",	//��������(����)
		"1.2.410.200004.5.1.1.7",	//��������(����)
		"1.2.410.200005.1.1.1",		//����������(����)
		"1.2.410.200005.1.1.5",		//����������(����)
		"1.2.410.200004.5.3.1.9",	//�ѱ������(����)
		"1.2.410.200004.5.3.1.2",	//�ѱ������(����)
		"1.2.410.200004.5.3.1.1",	//�ѱ������(���)
		"1.2.410.200004.5.4.1.1",	//��������(����)
		"1.2.410.200004.5.4.1.2",	//��������(����)
		"1.2.410.200012.1.1.1",		//�ѱ������������(����)
		"1.2.410.200012.1.1.3",		//�ѱ������������(����)
	};

	byte[] ServerSignCert = null;
	byte[] ServerSignKey = null;
	byte[] ServerKmCert = null;
	byte[] ServerKmKey = null;
	String ServerSignCertPem = "";
	String ServerKmCertPem = "";
	String ServerKeyEncPassword = "";
	


%>

<%
	response.setHeader("Cache-Control","no-cache,no-store");
	response.setHeader("Pragma","no-cache,no-store");

	try
		{
			// ������ ��ȣȭ�� ������ �� ����Ű Read
			
			ServerSignCert = FileUtil.readBytesFromFileName(ServerSignCertFile);
			ServerSignKey = FileUtil.readBytesFromFileName(ServerSignKeyFile);
			ServerKmCert = FileUtil.readBytesFromFileName(ServerKmCertFile);
			ServerKmKey = FileUtil.readBytesFromFileName(ServerKmKeyFile);
			
			// ������������ PEM���·� ���� ���
			/*
			ServerSignCert = Base64Util.decode(FileUtil.readStringFromFileName(ServerSignCertFile));
			ServerSignKey = Base64Util.decode(FileUtil.readStringFromFileName(ServerSignKeyFile));
			ServerKmCert = Base64Util.decode(FileUtil.readStringFromFileName(ServerKmCertFile));
			ServerKmKey = Base64Util.decode(FileUtil.readStringFromFileName(ServerKmKeyFile));
			//ServerKmKey = FileUtil.readBytesFromFileName(ServerKmKeyFile);
			//String ServerKmKey = ServerCertPath + "kmPri.key";
			*/
			// PEM type �������� ��ȯ
			ServerSignCertPem = CertUtil.derToPem( ServerSignCert );
			ServerKmCertPem = CertUtil.derToPem( ServerKmCert );

			// ��ȣȭ�� ������ ����Ű ��й�ȣ ���� Read
			ServerKeyEncPassword = FileUtil.readStringFromFileName(ServerKeyEncPasswordPath);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
%>