<?php
defined('BASEPATH') or exit('No direct script access allowed');

class M_api extends CI_Model
{
   public function getUser($email, $password)
   {
      return $this->db->query("select id_user,email,role_id from t_user where email ='" . $email . "' and password = '" . $password . "'");
   }
   public function getSewa($id)
   {
      return $this->db->query("SELECT p.nama_barang,u.nama,p.lama_sewa,p.Tgl_kembali,p.status FROM t_penyewaan p, t_user u WHERE p.id_org = u.id_user AND u.id_user = '" . $id . "' AND date(p.tgl_sewa) = date(now());");
   }
}
