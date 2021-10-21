BEGIN
      DBMS_CLOUD.CREATE_CREDENTIAL(
        credential_name => 'ATPCS_CRED',
        username => 'mike@gangler.net',
        password => 'epzMy-xf;aIYDO35CHL-'
      );
END;

