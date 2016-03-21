<?php

class IndexController extends ControllerBase
{

    public function indexAction()
    {
        $latest     = $this->article->getLatestArticle(50);
        $most_like  = $this->lists->getMostLikePosts(50);

        $posts = array_merge($latest, $most_like);

        shuffle($posts);

        $this->view->posts = $posts;
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
        $this->view->post = $post;
        $this->view->latest_posts   = $this->article->getLatestArticle(10);
        $this->view->most_like      = $this->lists->getMostLikePosts();
        $this->view->same_board     = $this->lists->getBoardList($post['board'], 1);

    }

    public function listAction($board = false, $page = 1)
    {
//        $board = $this->dispatcher->getParam('board', 'string', false);
//        $page = $this->dispatcher->getParam('page', 'int', 0);

        if ( $board == false ) $this->response->redirect('/');

        $this->view->board = $board;
        $this->view->page = $page;
        $this->view->data = $this->lists->getBoardList($board, $page);
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

}

