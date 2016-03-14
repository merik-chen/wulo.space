<?php

class IndexController extends ControllerBase
{

    public function indexAction()
    {

    }

    public function detailAction()
    {
        $board = $this->dispatcher->getParam('board', 'string', false);
        $post = $this->dispatcher->getParam('post', 'string', false);

        if( $board == false || $post == false ) $this->response->redirect('/');

        $this->view->board  = $board;
        $this->view->post   = $post;
    }

    public function postGet5F()
    {
        if ($payload = $this->request->getPost('payload', 'array', false)) {
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

