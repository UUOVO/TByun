<?php
namespace app\controller;
use app\model\Book as BookModel;
use app\model\Bookwarehouse as warehouseModel;
use think\facade\Request;
use think\facade\Db;

class book{
    //添加图书
    public function addBook(){
        // $category=Request::param('category');
        $bookname=Request::param('bookname');
        $author=Request::param('author');
        $press=Request::param('press');
        $state=Request::param('state');
        $describe=Request::param('describe');
        // $img=Request::param('img');
        if(empty($bookname)||empty($press)||empty($state)){
            return json([
                "msg" => '别名、书名、出版社、状态不能为空'
            ],404);
        }
        $book=new BookModel;
        // $book->category=$category;
        $book->bookname=$bookname;
        $book->author=$author;
        $book->press=$press;
        $book->state=$state;
        $book->describe=$describe;
        // $book->img=$img;
        if($book->save()){
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
    //修改书籍
    public function modifyBook(){
        // $category=Request::param('category');
        $bookname=Request::param('bookname');
        $author=Request::param('author');
        $press=Request::param('press');
        $state=Request::param('state');
        $describe=Request::param('describe');
        // $img=Request::param('img');
        if(empty($bookname)){
            return json(['msg'=>'书名为空'],404);
        }
        $book=BookModel::where('bookname',$bookname)->find();
        // $book->category=$category;
        $book->bookname=$bookname;
        $book->author=$author;
        $book->press=$press;
        $book->state=$state;
        $book->describe=$describe;
        // $book->img=$img;
        if($book->save()){
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
    //删除图书
    public function delBook(){
        $bookid=Request::param('bookid');
        if(empty($bookid)){
            return json(['msg'=>'书名为空'],404);
        }
        $book=BookModel::where('id',$bookid)->find();
        if($book->delete()){
            return json(['msg'=>'成功'],200);
         }else{
             return json(['msg'=>'失败'],400);
         }
    }
    //录入库存
    public function entryBook(){
        $bookid=Request::post('bookid');
        $state=Request::post('state');
        $id = Request::post('id');
        // $id=time().rand(1,2);
        $Course=BookModel::where('id',$bookid)->find();//查询书名id
        if($Course==null){
            return json(['msg' => '错误'],404);
        }
        // $bookid=$Course['id'];
        $book=new warehouseModel;
        $book->bookname=$Course['bookname'];
        $book->id=$id;
        $book->state=$state;
        $book->bookid=$bookid;
        if($book->save()){
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
    //查询书籍
    public function findBook(){
        $book=Db::query("select * from t_book");
        return json($book);
    }

    public function getBookById(){
        $id = Request::post('bookId');
        $result = BookModel::where('id',$id)->find();
        return json($result);   
    }
    //查库存
    public function getBookNum(){
        $id = Request::post('bookId');
        $result = warehouseModel::where('bookid',$id)->select();
        return json($result);   
    }

    public function getBookNumOk(){
        $id = Request::post('bookId');
        $result = warehouseModel::where('bookid',$id)->where('state','1')->select();
        return json($result);   
    }
    
    public function search(){
        $keyword = Request::post('keyword');
        $result = BookModel::where('bookname','LIKE','%'.$keyword.'%')->select();
        return json($result,200);
    }
}