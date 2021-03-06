class socat ( $param='' ) {
	package { 'socat':
		ensure => installed,
	}

	file { '/etc/init.d/socat':
		source => 'puppet:///modules/socat/socat',
		require => Package['socat'],
		notify  => Service['socat'],
		owner   => root, group => root, mode => 0750;
	}

	file { '/etc/default/socat':
		owner   => root,
		group   => root,
		mode    => 664,
		content => template('socat/socat.erb'),
	}

	service { 'socat':
		ensure    => running,
		enable    => true,
		hasstatus => true,
		require   => Package['socat'],
	}
}
