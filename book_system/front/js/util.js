/**
 * 获取节点
 * @param {String} name - 选择器
 * */
function $(name) {
	return document.querySelector(name);
}

/**
 * 登录验证
 * */
function loginVerify() {
	let box = $('.btn_area');
	let username = localStorage.getItem('username');
	let id = localStorage.getItem('studentId');
	if (!username || !id)
		return;

	box.innerHTML =
		`
		<div>hello,${username} <span><a class="btn_area_logout" href="javascript:;" onclick="logout()">注销</a></span></div>
	`
}

function logout() {
	httpService.get('/user/logout', {}, res => {
		alert(res.msg)
		localStorage.removeItem('username')
		localStorage.removeItem('studentId')
		window.location.reload()
	}, err => {
		alert(err.msg)
	})
}

function popClose() {
	$('#addUserbox').style.display = 'none'
}

function getQueryString(url) {
	let exp = /([^?]+)?\?/g;
	let res = exp.exec(url);
	if(res == null){
		return {
			name:name = url.slice(1),
			data:null
		}
	}
	let str = url.slice(res[0].length)
	let data = str.split("&");
	

	data.forEach((item,index,array)=>{
		let a = item.split('=');
		a[0] = '\"'+a[0]+'\"'
		a[1] = '\"'+a[1]+'\"'
		array[index] = a.join(':');
	})
	str = '({'+ data.join(',') +'})'
	let  obj = eval(str);
	return {
		name: res[0].slice(1,res[0].length-1),
		data:obj
	}
}