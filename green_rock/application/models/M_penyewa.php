<?php
defined('BASEPATH') or exit('No direct script access allowed');

class M_penyewa extends CI_Model
{
    public function get_data()
    {
        return $this->db->get('tbl_user')->result();
    }
}