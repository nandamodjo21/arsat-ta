<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800"><?= $title; ?></h1>
    <div class="row">
        <div class="col-lg-12">
            <!-- DataTales Example -->
            <div class="card shadow mb-4">
                <div class="card-header py-3">

                    <a href="" class="btn btn-primary mb-3" data-toggle="modal" data-target="#tambahModal">Tambah
                        Data</a>
                </div>
                <div class=" card-body">

                    <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">

                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Nama Barang </th>
                                    <th>Stok</th>
                                    <th>Harga Per Hari</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $no = 1;
                                foreach ($barang as $br) : ?>
                                <tr>
                                    <td scope="row"><?= $no++; ?></td>
                                    <td><?= $br->nama_barang ?></td>
                                    <td><?= $br->stok_barang ?></td>
                                    <td><?= $br->harga_barang ?></td>
                                    <td>

                                        <a href="" class="badge badge-success" data-toggle="modal"
                                            data-target="#editbarang<?= $br->id ?>">edit</a>
                                        <a href="<?php echo base_url('Barang/delete/' . $br->id) ?>"
                                            class="badge badge-danger">delete</a>
                                    </td>

                                </tr>
                            </tbody>
                            <?php endforeach; ?>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="tambahModal" tabindex="-1" role="dialog" aria-labelledby="tambahModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="tambahModalLabel">Form Tambah Data</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="<?= base_url('Barang/tambah_data'); ?>" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label>Nama Barang</label>
                        <input type="text" name="nama" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Stok</label>
                        <input type="text" name="stok" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Harga</label>
                        <input type="text" name="harga" class="form-control">
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-primary">Simpan</button>
                </div>
            </form>
        </div>
    </div>
</div>
<?php $no = 1;
foreach ($edit as $br) : ?>
<!-- Modal edit-->
<div class="modal fade" id="editbarang<?= $br->id ?>" tabindex="-1" role="dialog" aria-labelledby="editbarangLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editbarangLabel">Form Edit</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="<?= base_url('Barang/edit_barang'); ?>" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <input type="hidden" value="<?= $br->id ?>" name="id" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Nama Barang</label>
                        <input type="text" value="<?= $br->nama_barang ?>" id="nama" name="nama" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Stok</label>
                        <input type="text" value="<?= $br->stok_barang ?>" id="stok" name="stok" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Harga</label>
                        <input type="text" value="<?= $br->harga_barang ?>" id="harga" name="harga"
                            class="form-control">
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-primary">Simpan</button>
                </div>
            </form>
        </div>
    </div>
</div>
<?php endforeach; ?>