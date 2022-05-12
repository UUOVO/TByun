<?php
namespace app\controller;

use app\model\Bookorder as bookorderModel;
use app\model\Bookwarehouse as warehouseModel;
use app\model\User as UserModel;
use think\facade\Request;
use app\util\Password;
use think\facade\Db;



class Reader{
    //查询书籍
    public function findBook(){
        $book=Db::query("select * from t_book");
        return json($book);
    }
    //修改个人信息
    public function updateUser(){
        $token = cookie('token');
        $info = cache($token);
        $id=$info['id'];
        $username=Request::post('username');
        $password=Password::md5(Request::post('password'));
        if( empty($username)||empty($password) ){
            return json([
                "msg" => '用户名或密码不能为空'
            ],404);
        }
        $user = UserModel::where('id',$id)->find();  
        $user->username=$username;
        $user->password=$password;
        if( $user->save()){
            $token = Password::md5(time().$user['id']);//重新获得COOKIE
            cache($token,[
                'id'=>$user['id'],
                'username'=>$user['username'],
                'role'=>$user['role']
            ]);
            return  json([
                "msg" => '成功',
                'data'=>[
                    'id'=>$user['id'],
                    'username'=>$user['username'],
                    'token'=>$token]
            ],200);
        }
        else{
            return json([
                "msg" => '失败'
            ],404) ;
        }     

    }

    //查询个人借书记录
    public function borrowRecord(){
        $token = cookie('token');
        $info = cache($token);
        $id=$info['id'];
        if($info['role'] == 1){
            $book=bookorderModel::where('studentid',$id)->select();
        }else if($info['role'] == 0){
            $book=bookorderModel::select();
        }
        return json($book);
    }

    public function getOrderList(){
        $book=bookorderModel::select();
        return json($book);
    }

    //借书籍
    public function borrowBooks(){
        $token = cookie('token');
        $info = cache($token);
        $studentid=$info['id'];
        $username=$info['username'];
        $bookid=Request::post('id');
        $count=warehouseModel::where('id',$bookid)->where('state',1)->find();//获取书的编号
        if($count==null){
            return json(['msg' => '错误'],404);
        }
        if($count['state'] == 0 ){
            return json(['msg' => '该书已借出'],404);
        }
        // $bookid=$count['id'];
        $time=rand(1,10).time();//生成借书编号
        $book=new bookorderModel;
        $book->username=$username;
        $book->studentid=$studentid;
        $book->id=$time;
        $book->bookname=$count['bookname'];
        $book->bookid=$count['id'];
        // $book->create_tiem=time();
        $book->status=1;
        if( $book->save()){
            $state=warehouseModel::where('id',$bookid)->find();//修改仓库书本状态
            $state->state=0;
            $state->save();
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
    //还书籍
    public function returnBook(){
        $token = cookie('token');
        $info = cache($token);
        $id=$info['id'];
        $idbook=Request::post('idbook');    //输入借书编号
        $book=bookorderModel::where('id',$idbook)->find();
        $bookid=$book['bookid'];
        $status=$book['status'];
        if($status == 0){
            return json(['msg => 此书已还'],404);
        }
        $book->status=0;
        $book->return_tiem=date('Y-m-d H:i:s',time());
        if( $book->save()){
            $state=warehouseModel::where('id',$bookid)->find();
            $state->state=1;
            $state->save();
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

}