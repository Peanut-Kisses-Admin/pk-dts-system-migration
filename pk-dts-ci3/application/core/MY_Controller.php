<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class MY_Controller extends CI_Controller
{
    protected $viewData = array();

    public function __construct()
    {
        parent::__construct();
        $this->viewData = array(
            'applicationName' => 'PK DTS',
            'environment' => defined('ENVIRONMENT') ? ENVIRONMENT : 'unknown',
        );
    }
}
