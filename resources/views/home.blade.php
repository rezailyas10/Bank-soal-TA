
@section('content')
    @role('ADMIN')
        @include('pages.admin.dashboard')
    @elserole('MITRA')
        @include('pages.mitra.dashboard')
    @elserole('USER')
        @include('pages.home') <!-- atau dashboard user -->
    @else
        <p>Silakan login untuk mengakses konten.</p>
    @endrole
@endsection
