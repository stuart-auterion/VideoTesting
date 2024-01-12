/*
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 *
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <gst/mpegts/mpegts.h>
#include "mpegtsbase.h"
#include "mpegtspacketizer.h"
#include "mpegtsparse.h"
#include "tsdemux.h"


static gboolean
plugin_init (GstPlugin * plugin)
{
  gst_mpegts_initialize ();
  if (!gst_mpegtsbase_plugin_init (plugin))
    return FALSE;
  if (!gst_mpegtsparse_plugin_init (plugin))
    return FALSE;
  if (!gst_ts_demux_plugin_init (plugin))
    return FALSE;
  return TRUE;
}


#ifndef GST_PACKAGE_NAME
#define GST_PACKAGE_NAME   "GStreamer Bad Plug-ins (custom)"
#define GST_PACKAGE_ORIGIN "Unknown package origin"
#define GST_LICENSE        "LGPL"
#define PACKAGE            "gst-plugins-bad (custom)"
#define PACKAGE_VERSION    "1.13.0.1"
#endif


GST_PLUGIN_DEFINE (GST_VERSION_MAJOR,
    GST_VERSION_MINOR,
    mpegtsdemux,
    "MPEG TS demuxer (custom)",
    plugin_init,  PACKAGE_VERSION, GST_LICENSE, GST_PACKAGE_NAME,
                  GST_PACKAGE_ORIGIN)
