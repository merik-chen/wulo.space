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

}

