      
      $ch = curl_init();
    	curl_setopt($ch, CURLOPT_URL, $url);
    	//参数为1表示传输数据，为0表示直接输出显示。
    	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    	//参数为0表示不带头文件，为1表示带头文件
    	curl_setopt($ch, CURLOPT_HEADER,0);
    	
        curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0); //强制协议为1.0
        curl_setopt($ch, CURLOPT_HTTPHEADER, array("Expect")); //头部要送出'Expect: 
        curl_setopt($ch, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4 ); //强制使用IPV4协议解析域名

    	$output = curl_exec($ch);
    	curl_close($ch);
    	 
    	$result=json_decode($output);
