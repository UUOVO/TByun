<?php
namespace app\controller;

use app\model\User as UserModel;
use think\facade\Request;
use app\util\Password;
use think\facade\Db;



class User{
    public function login(){
        $studentId=Request::post('studentId');
        $password=Password::md5(Request::post('password'));
        $user=UserModel::where('id',$studentId)->find();

        if(empty($studentId) !=1 &&$user['password'] == $password){
            $token = Password::md5(time().$user['id']);
            cache($token,[
                'id'=>$user['id'],
                'username'=>$user['username'],
                'role'=>$user['role']
            ]);
            
        }else{
            return json(['msg'=>'失败'],400);
        }
        return json([
            'msg'=>'登录成功',
            'data'=>[
                'id'=>$user['id'],
                'username'=>$user['username'],
                'token'=>$token,
                'role'=>$user['role']
            ]
        ],200);   
    }

    //新增用户
    public function addUser(){
        $studentId=Request::post('studentId');
        $username=Request::post('username');
        $password=Password::md5(Request::post('password'));
        $role=Request::post('role');
        if( empty($username)||empty($password||empty($studentId)) ){
            return json([
                "msg" => '学号、用户名、密码不能为空'
            ],404);
        }
        $user=new UserModel;
        $user->id=$studentId;
        $user->username=$username;
        $user->password=$password;
        $user->role=$role;
        if( $user->save()){
            return  json([
                "msg" => '成功'
            ],200);
        }
        else{
            return json([
                "msg" => '失败'
            ],404) ;
        }
    }

    //查询用户
    public function getUserlist(){
        $user=Db::query("select * from t_user");
        return json($user);      
    }

    public function getUserById(){
        $id = Request::post('studentId');
        $result = UserModel::where('id',$id)->find();
        return json($result);      
    }

    //更新用户
    public function updateUser(){
        $studentId=Request::post('studentId');
        $username=Request::post('username');
        $password=Password::md5(Request::post('password'));
        $role=Request::post('role');
        if( empty($username)||empty($studentId) ){
            return json([
                "msg" => '学号、用户名、密码不能为空'
            ],404);
        }
        $user = UserModel::where('id',$studentId)->find();
        $user->id=$studentId;
        $user->username=$username;
        if(!empty($password)){
            $user->password=$password;
        }
        $user->role=$role;
        if( $user->save()){
            return  json([
                "msg" => '成功'
            ],200);
        }
        else{
            return json([
                "msg" => '失败'
            ],404) ;
        }

    }

    //删除用户
    public function delUser(){
        $studentId=Request::post('studentId');
        if( empty($studentId)){
            return json([
                "msg" => '学号不能为空'
            ],404);
         }
         $user=UserModel::where('id',$studentId)->find();
         if($user->delete()){
            return json(['msg'=>'成功'],200);
         }else{
             return json(['msg'=>'失败'],400);
         }

    }

    public function logout(){
        if(cache(cookie('token'),NULL))
            return json(['msg'=>'成功'],200);
        return json(['msg'=>'失败'],400);

    }
}