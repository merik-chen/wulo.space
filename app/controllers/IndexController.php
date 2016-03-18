<?php

class IndexController extends ControllerBase
{

    public function indexAction()
    {
        $this->view->latest = $this->article->getLatestArticle();
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
        $this->view->post = $find['payload'];

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

