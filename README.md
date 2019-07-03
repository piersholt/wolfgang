# Wolfgang [![License: GPL-3.0-only](https://img.shields.io/github/license/piersholt/wolfgang.svg)](https://www.gnu.org/licenses/gpl-3.0)

Wolfgang is a car kit emulator, intended for use in automotive applications.

It supports Bluetooth device management, and audio streaming, the APIs for which are served over a lightweight messaging queue courtesy of ZeroMQ.

A complimentary client library also written in Ruby is available in [wilhelm-tools](https://github.com/piersholt/wilhelm-tools)), but any language with a ZeroMQ binding can be used to generate the API calls, which are just YAML or JSON blobs following a standardised structure.

The underlying Bluetooth profiles (A2DP, AVRCP etc) are implemented by [Bluez](http://www.bluez.org), so Wolfgang also includes a Ruby client for the Bluez D-BUS API.

The motivation for Wolfgang was the project [Walter](https://github.com/piersholt/walter), an interface for BMWs that use I/K-Bus, which required a friendly Bluetooth interface.

---

## License

This program is released under the GNU General Public License v3.0.

## About

This program uses the [Ruby D-Bus](https://github.com/mvidner/ruby-dbus) library, which is licensed under the GNU Lesser General Public Library, version 2.1, or any later version.
