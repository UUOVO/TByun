var httpService = {}

// let host = "http://localhost:8000";
// let host = location.origin + location.pathname.slice(0,-6) + '/tp/public';
let host = "http://127.0.0.1:80/tp/public";


httpService.host = host;

/**
 * GET请求
 * @param {String} hash - 接口名
 * @param {Object} param - 参数
 * @param {type}  - 成功的回调
 * @param {type} hash - 失败的回调
 * */
httpService.get = function(hash, param, succeed, error) {
	let xmlhttp = new XMLHttpRequest();

	let uri = host + hash;

	if (param) {
		uri += '?';
		for (let item in param) {
			uri += item + '=' + param[item] + '&';
		}
		uri = uri.slice(0, uri.length - 1);
	}

	xmlhttp.open('get', uri, true);
	xmlhttp.withCredentials = true;
	xmlhttp.send();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			succeed(eval("(" + xmlhttp.responseText + ")"));
		}
		if (xmlhttp.readyState == 4 && xmlhttp.status != 200) {
			error(eval("(" + xmlhttp.responseText + ")"));
		}
	}
}

httpService.post = function(hash, param, succeed, error) {
	let xmlhttp = new XMLHttpRequest();

	let uri = host + hash;

	let poststr = ''
	if (param) {
		for (let item in param) {
			poststr += item + '=' + param[item] + '&';
		}
		poststr = poststr.slice(0, poststr.length - 1);
	}

	xmlhttp.open('POST', uri, true);
	xmlhttp.withCredentials = true;
	xmlhttp.setRequestHeader('content-type', 'application/x-www-form-urlencoded');
	xmlhttp.send(poststr);

	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			succeed(eval("(" + xmlhttp.responseText + ")"));
		}
		if (xmlhttp.readyState == 4 && xmlhttp.status != 200) {
			error(eval("(" + xmlhttp.responseText + ")"));
		}
	}
}
