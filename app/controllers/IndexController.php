<?php

class IndexController extends ControllerBase
{

    public function indexAction()
    {
        $latest     = $this->article->getLatestArticle(50);
        $most_like  = $this->lists->getMostLikePosts(50);
        $all_board  = $this->lists->getAllBoards();

        $posts = array_merge($latest, $most_like);

        shuffle($posts);
        shuffle($all_board);

        $this->ab['index'] = [
            'cta' => rand(0,999) >= 500 ? '-outline' : null
        ];

        $this->view->ab = $this->ab;
        $this->view->posts  = $posts;
        $this->view->boards = $all_board;
    }

    public function detailAction()
    {
        $board = $this->dispatcher->getParam('board', 'string', false);
        $post = $this->dispatcher->getParam('post', 'string', false);

        if( $board == false || $post == false ) $this->response->redirect('/');

        $find = $this->article->getArticle([
            'board' => $board,
            'article' => $post
        ]);

        if ($find['status'] !== true) $this->response->redirect('/');

        $this->view->board  = $board;
        $this->view->article= $post;

        unset($find['payload']['_id']);
        $post = $find['payload'];

        $this->view->post       = $post;
        $this->view->most_like  = $this->lists->getMostLikePosts();

        $latest_posts   = $this->article->getLatestArticle(50);
        $same_board     = $this->lists->getBoardList($post['board'], 1);
        $same_board     = $same_board['list'];
        $all_board      = $this->lists->getAllBoards();
        shuffle($all_board);
        shuffle($same_board);
        shuffle($latest_posts);
        $this->view->latest_posts   = $latest_posts;
        $this->view->same_board     = $same_board;
        $this->view->boards         = $all_board;

    }

    public function listAction($board = false, $page = 1)
    {
//        $board = $this->dispatcher->getParam('board', 'string', false);
//        $page = $this->dispatcher->getParam('page', 'int', 0);

        if ( $board == false ) $this->response->redirect('/');

        $all_board = $this->lists->getAllBoards();
        shuffle($all_board);
        $this->view->boards = $all_board;
        $this->view->board  = $board;
        $this->view->page   = $page;
        $this->view->data   = $this->lists->getBoardList($board, $page);
    }

    public function postGet5FAction()
    {
        if ($payload = $this->request->getPost('payload', null, false)) {
            if ($this->request->isAjax()) {
                $this->response->setJsonContent(
                    $this->article->getArticle($payload)
                );
            } else {
                $this->response->setStatusCode(401);
            }
        } else {
            $this->response->setStatusCode(403);
        }

        $this->response->send();
    }

    public function getScreenshotAction()
    {
        $board = $this->dispatcher->getParam('board', 'string', false);
        $post = $this->dispatcher->getParam('post', 'string', false);

        $original = $this->request->hasQuery('orig');

        if( $board == false || $post == false ) $this->response->redirect('/');

        $this->view->disable();

        $hash = sha1("https://www.ptt.cc/bbs/$board/$post.html");

        if($find = $this->attachment->getScreenShot($hash))
        {
            $this->response->setContentType($find['content-type']);
            $this->response->sendHeaders();
            if($original)
            {
                echo $find['file']->bin;
            }else{
                echo $find['thumbnail']->bin;
            }
        }else{
            $this->response->redirect('/');
        }

        return;
    }

}

